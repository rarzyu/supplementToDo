import 'package:intl/intl.dart';
import 'package:supplement_to_do/core/data/database/dto/tasks_dto.dart';
import '../config/constants/db/tasks_table_constants.dart';
import '../core/data/database/dao/tasks_dao.dart';
import '../core/data/database/db_helper.dart';

///タスクテーブルのCRUD操作
class TasksTableService {
  TasksDao tasksDao = TasksDao(DBHelper.instance);

  ///日付からタスクテーブルのデータを取得する
  Future<List<TasksDto>> getTaskTableForDate(DateTime selectedDate) async {
    final String selectedDateString =
        DateFormat('yyyy-MM-dd').format(selectedDate);

    //抽出用の条件クラスを作成する
    TasksQueryOption tasksQueryOption = TasksQueryOption(
        conditions: [TasksTableConstants.scheduledDate],
        conditionValues: [selectedDateString],
        sortColumns: [TasksTableConstants.scheduledTime],
        isASC: [true]);

    //抽出
    List<TasksDto> _res = await tasksDao.tasksQuery(tasksQueryOption);
    return _res;
  }

  ///IDからタスクテーブルのデータを取得する
  Future<List<TasksDto>> getTaskTableForId(int id) async {
    //抽出用の条件クラスを作成する
    TasksQueryOption tasksQueryOption = TasksQueryOption(
        conditions: [TasksTableConstants.id], conditionValues: [id]);

    //抽出
    List<TasksDto> _res = await tasksDao.tasksQuery(tasksQueryOption);
    return _res;
  }

  ///DTOからINSERT
  Future<int> insertTaskTable(TasksDto dto) async {
    int _res = await tasksDao.insertTasks(dto);
    return _res;
  }

  ///DTOからUPDATE
  Future<int> updateTaskTable(TasksDto dto) async {
    int _res = await tasksDao.updateTasks(dto);
    return _res;
  }

  ///IDからDELETE
  Future<int> deleteTaskTable(int id) async {
    int _res = await tasksDao.deleteTasks(id);
    return _res;
  }
}
