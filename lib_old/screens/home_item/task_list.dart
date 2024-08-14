import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../models/base_task_model.dart';
import '../../providers/edit_task_notifier.dart';
import '../../providers/task_list_notifier.dart';
import '../add_edit_screen.dart';
import '../../providers/date_manager_notifier.dart';
import '../../services/ad_manager.dart';

///タスク一覧セクション
///セクション全体
class TaskList extends StatelessWidget {
  AdManager? adManager;

  TaskList() {
    adManager = AdManager();
  }

  dispose() {
    adManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //状態管理
    final taskListNotifierRead = context.read<TaskListNotifier>();
    final taskListNotifierWatch = context.watch<TaskListNotifier>();
    final dateNotifierRead = context.read<DateManagerNotifier>();

    //その日付のデータを取得する
    taskListNotifierRead.getTaskList(dateNotifierRead.selectedDate);
    List taskList = taskListNotifierWatch.taskListModel.taskList;

    return Expanded(
      child: taskList.length == 0
          ? Center(
              child: Text(
                'データがありません',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontBlackBold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) => ListItem(
                    index: index,
                    taskModel: taskList[index],
                    taskListNotifierRead: taskListNotifierRead,
                    adManager: adManager!,
                  )),
    );
  }
}

///リストのアイテム
class ListItem extends StatelessWidget {
  final int index;
  final BaseTaskModel taskModel;
  final TaskListNotifier taskListNotifierRead;
  final AdManager adManager;

  ListItem(
      {required this.index,
      required this.taskModel,
      required this.taskListNotifierRead,
      required this.adManager});

  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    int taskId = taskModel.taskId;

    return GestureDetector(
      //タップ領域をpaddingなども含めるようにする
      behavior: HitTestBehavior.opaque,

      onTap: () {
        //タスクの取得
        //この処理で編集モードにもなる
        editTaskNotifierRead.getEditTaskForId(taskId);

        //少し遅延
        Future.delayed(Duration(milliseconds: 20), () {
          adManager.showInterstitialAd();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddEditScreen();
          }));
        });
      },

      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderGray,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //チェックボックス
              SizedBox(
                child: TaskCheckBox(),
              ),
              //タスク名
              Expanded(
                child: TaskTitle(),
              ),
              //分類ラベル
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: ClassificationLabel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///チェックボックス
  Checkbox TaskCheckBox() {
    return Checkbox(
        value: taskModel.completed,
        onChanged: (bool? value) {
          taskModel.completed = value ?? false;
          taskListNotifierRead.updateTask(taskModel);
        });
  }

  ///タスクタイトル
  Text TaskTitle() {
    return Text(
      taskModel.supplementName,
      style: TextStyle(
        color: AppColors.fontBlack,
        fontSize: 18.0,
        decoration: taskModel.completed
            ? TextDecoration.lineThrough
            : TextDecoration.none,
      ),
    );
  }

  ///分類ラベル
  Container ClassificationLabel() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.baseObjectDarkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        taskModel.classificationName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
