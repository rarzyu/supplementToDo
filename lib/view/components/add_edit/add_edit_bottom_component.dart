import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constant.dart';
import '../../../services/add_edit_task_service.dart';
import '../../../services/notification_manager.dart';
import '../../../services/notification_service.dart';
import '../common/alert_component.dart';
import '../../../../lib_old/providers/edit_task_notifier.dart';

///ボトム部分
class AddEditBottomComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sectionTitleLightGray,
      height: kBottomNavigationBarHeight * 1.3, //規定のボトムバーの高さ
      width: double.infinity,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          //完了ボタン押下時の処理
          onPressedCompleteButton(context);
        },
        child: Text(
          '完了',
          style: TextStyle(
              color: AppColors.baseObjectDarkBlue,
              fontSize: 22.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  ///完了ボタン押下時の処理
  void onPressedCompleteButton(BuildContext context) {
    //状態管理
    final editTaskNotifier =
        Provider.of<EditTaskNotifier>(context, listen: false);
    bool isEditMode = editTaskNotifier.isEditMode;

    DateTime now = DateTime.now();

    NotificationManager notificationManager = NotificationManager();
    notificationManager.init();

    //バリデーションチェック
    String validationMessage = editTaskNotifier.validationCheck();
    if (validationMessage != '') {
      String title = '項目エラー';
      Icon icon = Icon(
        Icons.error,
        color: Colors.red,
      );

      //エラー時処理
      Alert().showGeneralMessageAlert(context, title, validationMessage, icon);
      return;
    }

    //完了ボタン押下時の処理
    //このトリガーでDBに反映させる
    AddEditTaskService addEditTaskService =
        AddEditTaskService(editTaskNotifierRead: editTaskNotifier);

    if (isEditMode) {
      //編集
      addEditTaskService.updateTask();

      //現在日時より後の場合は通知を更新
      if (editTaskNotifier.scheduleDateTime.isAfter(now)) {
        notificationManager.updateNotification(editTaskNotifier.taskId,
            editTaskNotifier.supplementName, editTaskNotifier.scheduleDateTime);
      }
    } else {
      //追加
      addEditTaskService.insertTask();

      //現在日時より後の場合は通知を追加
      if (editTaskNotifier.scheduleDateTime.isAfter(now)) {
        notificationManager.scheduleNotification(editTaskNotifier.taskId,
            editTaskNotifier.supplementName, editTaskNotifier.scheduleDateTime);
      }
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(isEditMode ? '更新しました' : '追加しました'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
