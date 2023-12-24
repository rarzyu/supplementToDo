import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/services/add_edit_task_service.dart';
import 'package:supplement_to_do/services/notification_service.dart';
import 'package:supplement_to_do/widgets/alert.dart';
import '../../providers/edit_task_notifier.dart';

///ボトム部分
class AddEditBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    final editTaskNotifierRead = context.read<EditTaskNotifier>();
    bool isEditMode = editTaskNotifierWatch.isEditMode;

    final NotificationService notificationService = NotificationService();

    return Container(
      color: AppColors.sectionTitleLightGray,
      height: kBottomNavigationBarHeight * 1.3, //規定のボトムバーの高さ
      width: double.infinity,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          String validationMessage = editTaskNotifierRead.validationCheck();
          //バリデーションチェック
          if (validationMessage != '') {
            String title = '項目エラー';
            Icon icon = Icon(
              Icons.error,
              color: Colors.red,
            );

            //エラー時処理
            Alert().showGeneralMessageAlert(
                context, title, validationMessage, icon);
            return;
          }

          //完了ボタン押下時の処理
          //このトリガーでDBに反映させる
          AddEditTaskService addEditTaskService =
              AddEditTaskService(editTaskNotifierRead: editTaskNotifierRead);

          if (isEditMode) {
            //編集
            addEditTaskService.updateTask();
          } else {
            //追加
            addEditTaskService.insertTask();
          }

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(isEditMode ? '更新しました' : '追加しました'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Text('OK'))
                  ],
                );
              });
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
}
