import 'package:intl/intl.dart';
import 'package:supplement_to_do/core/data/database/dto/tasks_dto.dart';
import '../config/constants/db/tasks_table_constants.dart';
import '../core/data/database/dao/tasks_dao.dart';
import '../core/data/database/db_helper.dart';

///タスクテーブルのCRUD操作
class TasksTableService {
  ///選択した日付
  final DateTime selectedDate;

  ///ID
  final int id;

  TasksTableService({
    required this.selectedDate,
    required this.id,
  });

  ///ローカル変数群
  TasksDao tasksDao = TasksDao(DBHelper.instance);

  ///日付からタスクテーブルのデータを取得する
  List<TasksDto> getTaskTableForDate() {
    List<TasksDto> _res = [];
    final String selectedDateString =
        DateFormat('yyyy-MM-dd').format(selectedDate);

    //抽出用の条件クラスを作成する
    TasksQueryOption tasksQueryOption = TasksQueryOption(conditions: [
      TasksTableConstants.scheduledDate
    ], conditionValues: [
      selectedDateString
    ], sortColumns: [
      TasksTableConstants.scheduledDate,
      TasksTableConstants.scheduledTime
    ], isASC: [
      true,
      true
    ]);

    //抽出
    Future<List<TasksDto>> queryResult = tasksDao.tasksQuery(tasksQueryOption);
    queryResult.then((value) => _res);

    return _res;
  }

  ///IDからタスクテーブルのデータを取得する
  List<TasksDto> getTaskTableForId() {
    List<TasksDto> _res = [];

    //抽出用の条件クラスを作成する
    TasksQueryOption tasksQueryOption = TasksQueryOption(conditions: [
      TasksTableConstants.id
    ], conditionValues: [
      id
    ], sortColumns: [
      TasksTableConstants.scheduledDate,
      TasksTableConstants.scheduledTime
    ], isASC: [
      true,
      true
    ]);

    //抽出
    Future<List<TasksDto>> queryResult = tasksDao.tasksQuery(tasksQueryOption);
    queryResult.then((value) => _res);

    return _res;
  }
}
