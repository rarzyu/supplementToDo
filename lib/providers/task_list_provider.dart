import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/task_list_model.dart';
import '../services/task_list_service.dart';
import '../../lib_old/models/base_task_model.dart';

///タスクリストModel用Provider
final taskListProvider = ChangeNotifierProvider<TaskListNotifier>(
    create: (context) => TaskListNotifier());

class TaskListNotifier with ChangeNotifier {
  TaskListModel taskListModel;

  TaskListNotifier() : taskListModel = TaskListModel(taskList: []);

  ///ゲッター
  TaskListModel get model => taskListModel;

  ///DBからデータを取得し、モデルに変換
  void getTaskList(DateTime selectedDate) async {
    TaskListService taskListService = TaskListService();

    //DBからデータを取得
    taskListModel = await taskListService.getSelectedDateTaskList(selectedDate);

    notifyListeners();
  }

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

      ///DBに更新を反映させる
      TaskListService taskListService = TaskListService();
      taskListService.updateCompleted(
          updatedTask.taskId, updatedTask.completed);

      notifyListeners();
    }
  }

  ///リストから削除
  void removeTask(int taskId) {
    taskListModel.taskList.removeWhere((task) => task.taskId == taskId);
    notifyListeners();
  }
}
