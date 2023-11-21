import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/models/base_task_model.dart';
import 'package:supplement_to_do/providers/edit_task_notifier.dart';
import 'package:supplement_to_do/providers/task_list_notifier.dart';
import 'package:supplement_to_do/screens/add_edit_screen.dart';

///タスク一覧セクション
///セクション全体
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final taskListNotifierRead = context.read<TaskListNotifier>(); //更新用
    final taskListNotifierWatch = context.watch<TaskListNotifier>(); //読み取り用
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
                  )),
    );
  }
}

///リストのアイテム
class ListItem extends StatelessWidget {
  final int index;
  final BaseTaskModel taskModel;
  final TaskListNotifier taskListNotifierRead;
  const ListItem(
      {required this.index,
      required this.taskModel,
      required this.taskListNotifierRead});

  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    return GestureDetector(
      //タップ領域をpaddingなども含めるようにする
      behavior: HitTestBehavior.opaque,

      onTap: () {
        //フラグを編集モードに
        editTaskNotifierRead.setEditModeFlg(true);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddEditScreen();
        }));
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
