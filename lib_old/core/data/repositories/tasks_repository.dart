import '../database/dao/tasks_dao.dart';
import '../database/dto/tasks_dto.dart';
import '../database/db_helper.dart';

///グローバル変数
const String tableName = 't_tasks';

///t_tasksのロジック部分
class TasksRepository {
  final TasksDao dbHelper = TasksDao(DBHelper.instance);

  ///INSERT
  Future<int> addClassification(TasksDto tasks) async {
    return await dbHelper.insertTasks(tasks);
  }

  ///SELECT ALL
  Future<List<TasksDto>> fetchClassificationAll() async {
    return await dbHelper.getAllTasks();
  }

  ///SELECT 条件指定
  Future<List<TasksDto>> fetchClassificationQuery(
      TasksQueryOption option) async {
    return await dbHelper.tasksQuery(option);
  }

  ///UPDATE
  Future<int> updateClassification(TasksDto tasks) async {
    return await dbHelper.updateTasks(tasks);
  }

  ///DELETE
  Future<int> removeClassification(int id) async {
    return await dbHelper.deleteTasks(id);
  }
}
