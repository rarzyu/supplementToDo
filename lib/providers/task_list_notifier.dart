import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/task_list_model.dart';

import '../models/base_task_model.dart';

///タスクリストModel用Provider
final taskListProvider = ChangeNotifierProvider<TaskListNotifier>(
    create: (context) => TaskListNotifier());

class TaskListNotifier with ChangeNotifier {
  TaskListModel taskListModel;

  TaskListNotifier() : taskListModel = TaskListModel(taskList: []);

  ///ゲッター
  TaskListModel get model => taskListModel;

  ///セッター
  ///リストの追加
  void addTask(BaseTaskModel task) {
    taskListModel.taskList.add(task);
    notifyListeners();
  }

  ///リストの更新
  void updateTask(BaseTaskModel updatedTask) {
    final index = taskListModel.taskList
        .indexWhere((task) => task.taskId == updatedTask.taskId);

    //要素が見つかる場合のみ実行
    if (index != -1) {
      taskListModel.taskList[index] = updatedTask;
      notifyListeners();
    }
  }

  ///リストから削除
  void removeTask(int taskId) {
    taskListModel.taskList.removeWhere((task) => task.taskId == taskId);
    notifyListeners();
  }
}
