import 'package:flutter/material.dart';
import 'package:supplement_to_do/core/data/database/dao/tasks_dao.dart';
import 'package:supplement_to_do/core/data/database/db_helper.dart';

///タスクのCRUD操作クラス
///ホーム画面用
class TaskListService {
  final DateTime selectedDate;
  TaskListService({
    required this.selectedDate,
  });
}

///タスクテーブル
class TaskTableService {
  final DateTime selectedDate;
  TaskTableService({
    required this.selectedDate,
  });

  final DBHelper dbHelper = DBHelper.instance;

  ///日付からタスクテーブルのデータを取得する
  List<Map<String, dynamic>> getTaskTable() {
    List<Map<String, dynamic>> _res = [];
    TasksDao tasksDao = TasksDao(dbHelper);

    //抽出用の条件クラスを作成する
    TasksQueryOption tasksQueryOption = TasksQueryOption(conditions: []);
    return _res;
  }
}
