import 'package:supplement_to_do/core/data/database/dto/classification_dto.dart';
import 'package:supplement_to_do/core/data/database/dto/supplements_dto.dart';
import 'package:supplement_to_do/core/data/database/dto/tasks_dto.dart';
import 'package:supplement_to_do/models/base_task_model.dart';
import 'package:supplement_to_do/models/task_list_model.dart';
import 'package:supplement_to_do/services/classification_master_service.dart';
import 'package:supplement_to_do/services/supplements_table_service.dart';
import 'package:supplement_to_do/services/tasks_table_service.dart';

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
}
