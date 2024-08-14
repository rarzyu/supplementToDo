import '../../lib_old/core/data/database/dto/classification_dto.dart';
import '../../lib_old/core/data/database/dto/supplements_dto.dart';
import '../../lib_old/core/data/database/dto/tasks_dto.dart';
import '../data/models/base_task_model.dart';
import '../data/models/task_list_model.dart';
import 'classification_master_service.dart';
import 'supplements_table_service.dart';
import 'tasks_table_service.dart';
import '../utils/date_time_util.dart';

///タスクリストのCRUD操作クラス
///ホーム画面用
class TaskListService {
  ///タスクリストの取得
  ///Notifierで格納する
  ///引数：
  ///- selectedDate: 選択された日付
  ///戻り値：
  ///- TaskListModel: タスクリスト
  Future<TaskListModel> getSelectedDateTaskList(DateTime selectedDate) async {
    TasksTableService tasksService = TasksTableService();
    SupplementsTableService supplementsService = SupplementsTableService();
    ClassificationMasterService classificationService =
        ClassificationMasterService();

    TaskListModel _res = TaskListModel(taskList: []);

    //タスクテーブルから取得
    List<TasksDto> resultTasks =
        await tasksService.getTaskTableForDate(selectedDate);

    //取得したデータが0件の場合は、空のリストを返す
    if (resultTasks.isEmpty) {
      return _res;
    }

    //取得したデータ数だけループ
    for (var i = 0; i < resultTasks.length; i++) {
      //タスクテーブルから取得したデータから、サプリメント名をサプリメントテーブルから取得
      int supplementId = resultTasks[i].supplementId;
      List<SupplementsDto> resultSupplements =
          await supplementsService.getSupplementsForId(supplementId);

      //取得したデータが0件の場合は、空のリストを返す
      if (resultSupplements.isEmpty) {
        return _res;
      }

      //タスクテーブルから取得したデータから、分類名を分類テーブルから取得
      //IDから取得するので、必ず1つだけ取得される
      int classificationId = resultSupplements[0].classificationId;
      List<ClassificationDto> resultClassifications =
          await classificationService.getClassificationForId(classificationId);

      //取得したデータが0件の場合は、空のリストを返す
      if (resultClassifications.isEmpty) {
        return _res;
      }

      //予定日と予定時刻を1つに
      DateTime scheduledDate = DateTime.parse(resultTasks[i].scheduledDate);
      List<String> scheduledTime =
          resultTasks[i].scheduledTime.split(':'); //時刻はそのまま変換できないので、文字列から作成する
      DateTime scheduledDateTime = DateTime(
          scheduledDate.year,
          scheduledDate.month,
          scheduledDate.day,
          int.parse(scheduledTime[0]),
          int.parse(scheduledTime[1]));

      //上記までの結果をもとに、BaseTaskModelを作成
      BaseTaskModel baseTaskModel = BaseTaskModel(
          taskId: resultTasks[i].id,
          supplementId: supplementId,
          supplementName: resultSupplements[0].supplementName,
          classificationId: classificationId,
          classificationName: resultClassifications[0].name,
          scheduledDateTime: scheduledDateTime,
          completed: resultTasks[i].completed == 0 ? false : true);

      _res.taskList.add(baseTaskModel);
    }
    return _res;
  }

  ///完了フラグの更新
  ///引数：
  ///- taskId: タスクID
  ///- completed: 完了フラグ
  Future<int> updateCompleted(int taskId, bool completed) async {
    TasksTableService tasksService = TasksTableService();

    //タスクテーブルのデータを取得
    List<TasksDto> resultTasks = await tasksService.getTaskTableForId(taskId);

    //取得したデータが0件の場合は、0を返す
    if (resultTasks.isEmpty) {
      return 0;
    }

    //取得したデータが1件の場合は、更新を実行
    if (resultTasks.length == 1) {
      String updateTime = DateTimeCommon().createTimeStamp(DateTime.now());

      //更新用のDTOを作成
      TasksDto updateDto = TasksDto(
          id: taskId,
          repeatId: resultTasks[0].repeatId,
          supplementId: resultTasks[0].supplementId,
          details: resultTasks[0].details,
          scheduledDate: resultTasks[0].scheduledDate,
          scheduledTime: resultTasks[0].scheduledTime,
          completed: completed ? 1 : 0,
          createdDateTime: resultTasks[0].createdDateTime,
          updatedDateTime: updateTime);

      //更新
      int _res = await tasksService.updateTaskTable(updateDto);
      return _res;
    }

    //取得したデータが2件以上の場合は、0を返す
    return 0;
  }
}
