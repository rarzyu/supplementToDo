import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/models/edit_task_model.dart';

///編集用タスクModelのProvider
final editTaskProvider = ChangeNotifierProvider<EditTaskNotifier>(
    create: (context) => EditTaskNotifier());

class EditTaskNotifier with ChangeNotifier {
  EditTaskModel editTaskModel;

  ///初期化
  EditTaskNotifier()
      : editTaskModel = EditTaskModel(
            isEditMode: false,
            taskId: 0,
            supplementId: 0,
            supplementName: '',
            classificationId: 0,
            classificationName: '',
            scheduledDateTime: DateTime.now(),
            completed: false,
            detail: '',
            repeatId: 0,
            repeatCode: 0,
            repeatTitle: '',
            dayOfWeek: '',
            interval: 0);

  ///ゲッター
  bool get isEditMode => editTaskModel.isEditMode;
  int get taskId => editTaskModel.taskId;
  int get supplementId => editTaskModel.supplementId;
  String get supplementName => editTaskModel.supplementName;
  int get classificationId => editTaskModel.classificationId;
  String get classificationName => editTaskModel.classificationName;
  DateTime get scheduleDateTime => editTaskModel.scheduledDateTime;
  bool get completed => editTaskModel.completed;
  String get detail => editTaskModel.detail;
  int get repeatId => editTaskModel.repeatId;
  int get repeatCode => editTaskModel.repeatCode;
  String get repeatTitle => editTaskModel.repeatTitle;
  String get dayOfWeek => editTaskModel.dayOfWeek;
  int get interval => editTaskModel.interval;

  ///セッター
  void setEditModeFlg(bool flg) {
    editTaskModel.isEditMode = flg;
    notifyListeners();
  }

  void setTaskId(int id) {
    editTaskModel.taskId = id;
    notifyListeners();
  }

  void setSupplimentId(int id) {
    editTaskModel.supplementId = id;
    notifyListeners();
  }

  void setSupplementName(String name) {
    editTaskModel.supplementName = name;
    notifyListeners();
  }

  void setClassificationId(int id) {
    editTaskModel.classificationId = id;
    notifyListeners();
  }

  void setClassificationName(String name) {
    editTaskModel.classificationName = name;
    notifyListeners();
  }

  void setScheduleDateTime(DateTime date) {
    editTaskModel.scheduledDateTime = date;
    notifyListeners();
  }

  void setCompleted(bool flg) {
    editTaskModel.completed = flg;
    notifyListeners();
  }

  void setDetail(String text) {
    editTaskModel.detail = text;
    notifyListeners();
  }

  void setRepeatId(int id) {
    editTaskModel.repeatId = id;
    notifyListeners();
  }

  void setRepeatCode(int code) {
    editTaskModel.repeatCode = code;
    notifyListeners();
  }

  void setRepeatTitle(String title) {
    editTaskModel.repeatTitle = title;
    notifyListeners();
  }

  void setDayOfWeek(String weekday) {
    editTaskModel.dayOfWeek = weekday;
    notifyListeners();
  }

  void setInterval(int interval) {
    editTaskModel.interval = interval;
    notifyListeners();
  }

  ///メソッド
  void resetAll() {
    editTaskModel = EditTaskModel(
        isEditMode: false,
        taskId: 0,
        supplementId: 0,
        supplementName: '',
        classificationId: 0,
        classificationName: '',
        scheduledDateTime: DateTime.now(),
        completed: false,
        detail: '',
        repeatId: 0,
        repeatCode: 0,
        repeatTitle: '',
        dayOfWeek: '',
        interval: 0);
  }
}
