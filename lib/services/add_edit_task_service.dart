import 'package:intl/intl.dart';
import 'package:supplement_to_do/core/data/database/dto/repeats_dto.dart';
import 'package:supplement_to_do/core/data/database/dto/supplements_dto.dart';
import 'package:supplement_to_do/core/data/database/dto/tasks_dto.dart';
import 'package:supplement_to_do/providers/edit_task_notifier.dart';
import 'package:supplement_to_do/services/repeats_table_service.dart';
import 'package:supplement_to_do/services/supplements_table_service.dart';
import 'package:supplement_to_do/services/tasks_table_service.dart';
import 'package:supplement_to_do/utils/date_time_common.dart';

///追加・編集用のCRUD操作
class AddEditTaskService {
  final EditTaskNotifier editTaskNotifierRead;

  AddEditTaskService({
    required this.editTaskNotifierRead,
  });

  ///TODO
  ///タスクの取得
  ///タスクの取得は画面側から呼び出す
  ///また、その際は編集モードの時のみ

  ///タスクの追加
  void insertTask() async {
    String createdDateTime = DateTimeCommon().createTimeStamp(DateTime.now());
    String scheduledDate =
        DateFormat('yyyy-MM-dd').format(editTaskNotifierRead.scheduleDateTime);
    String scheduledTime =
        DateFormat('hh:mm:ss').format(editTaskNotifierRead.scheduleDateTime);

    //サプリメントテーブル
    SupplementsTableService supplementsService = SupplementsTableService();
    //サプリメント名が存在するかチェック
    List<SupplementsDto> supplementsResult = await supplementsService
        .getSupplementsForName(editTaskNotifierRead.supplementName);

    //すでに存在する場合、そのIDでタスクテーブルに登録。そうで無ければINSERT
    int supplementsId = 0;
    if (supplementsResult.isEmpty) {
      //INSERT
      //DTOの作成
      SupplementsDto supplementsDto = SupplementsDto(
          id: 0,
          supplementName: editTaskNotifierRead.supplementName,
          classificationId: editTaskNotifierRead.classificationId,
          createdDateTime: createdDateTime,
          updatedDateTime: '');

      //追加
      int supplementsResult =
          await supplementsService.insertSupplements(supplementsDto);
      supplementsId = supplementsResult;
    } else {
      supplementsId = supplementsResult[0].id;
    }

    //繰り返しテーブル
    RepeatsTableService repeatsService = RepeatsTableService();
    //DTOの作成
    RepeatsDto repeatsDto = RepeatsDto(
        id: 0,
        repeatCode: editTaskNotifierRead.repeatCode,
        repeatTitle: editTaskNotifierRead.repeatTitle,
        dayOfWeek: editTaskNotifierRead.dayOfWeek,
        interval: editTaskNotifierRead.interval,
        createdDateTime: createdDateTime,
        updatedDateTime: '');
    //insert
    int repeatsResult = await repeatsService.insertRepeats(repeatsDto);

    //タスクテーブル
    TasksTableService tasksService = TasksTableService();
    //DTOの作成
    TasksDto tasksDto = TasksDto(
        id: 0,
        supplementId: supplementsId,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        repeatId: repeatsResult,
        details: editTaskNotifierRead.detail,
        completed: editTaskNotifierRead.completed == true ? 1 : 0,
        createdDateTime: createdDateTime,
        updatedDateTime: '');
    //insert
    int tasksResult = await tasksService.insertTaskTableForDTO(tasksDto);
  }

  ///タスクの更新
  ///タスクの削除
}
