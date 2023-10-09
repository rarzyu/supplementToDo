import 'package:supplement_to_do/core/data/database/dao/tasks_dao.dart';
import 'package:supplement_to_do/core/data/database/dto/tasks_dto.dart';
import '../database/db_helper.dart';

///グローバル変数
const String tableName = 't_tasks';

///t_tasksのロジック部分
class TasksRepository {
  final SupplementsDao dbHelper = SupplementsDao(DBHelper.instance);

  ///INSERT
  Future<int> addClassification(SupplementsDto tasks) async {
    return await dbHelper.insertTask(tasks);
  }

  ///SELECT ALL
  Future<List<SupplementsDto>> fetchClassificationAll() async {
    return await dbHelper.getAllTasks();
  }

  ///SELECT 条件指定
  Future<List<Map<String, dynamic>>> fetchClassificationQuery(
      TaskQueryOption option) async {
    return await dbHelper.taskQuery(option);
  }

  ///UPDATE
  Future<int> updateClassification(SupplementsDto tasks) async {
    return await dbHelper.updateTask(tasks);
  }

  ///DELETE
  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteTask(id);
  }
}
