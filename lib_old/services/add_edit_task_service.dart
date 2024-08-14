import '../core/data/database/dto/classification_dto.dart';
import '../core/data/database/dto/repeats_dto.dart';
import '../core/data/database/dto/supplements_dto.dart';
import '../core/data/database/dto/tasks_dto.dart';
import '../models/edit_task_model.dart';
import '../providers/edit_task_notifier.dart';
import 'classification_master_service.dart';
import 'repeats_table_service.dart';
import 'supplements_table_service.dart';
import 'tasks_table_service.dart';
import '../utils/date_time_common.dart';

///追加・編集用のCRUD操作
class AddEditTaskService {
  final EditTaskNotifier editTaskNotifierRead;

  AddEditTaskService({
    required this.editTaskNotifierRead,
  });

  ///タスクの取得
  ///戻り値：EditTaskModel
  Future<EditTaskModel> getEditTaskForId(int tasksId) async {
    //タスクテーブル
    TasksTableService tasksService = TasksTableService();
    //タスクの取得
    List<TasksDto> tasksDto = await tasksService.getTaskTableForId(tasksId);

    //サプリメントテーブル
    SupplementsTableService supplementsService = SupplementsTableService();
    //サプリメントの取得
    List<SupplementsDto> supplementsDto =
        await supplementsService.getSupplementsForId(tasksDto[0].supplementId);

    //繰り返しテーブル
    RepeatsTableService repeatsService = RepeatsTableService();
    //繰り返しの取得
    List<RepeatsDto> repeatsDto =
        await repeatsService.getRepeatsForId(tasksDto[0].repeatId);

    //分類テーブル
    ClassificationMasterService classificationService =
        ClassificationMasterService();
    //分類の取得
    List<ClassificationDto> classificationDto = await classificationService
        .getClassificationForId(supplementsDto[0].classificationId);

    //予定日と予定時刻を1つにまとめる
    DateTime scheduledDateTime = DateTimeCommon()
        .createDateTime(tasksDto[0].scheduledDate, tasksDto[0].scheduledTime);

    //モデルの作成
    EditTaskModel editTaskModel = EditTaskModel(
        isEditMode: true, //編集モードでしか使わないので、true固定
        taskId: tasksDto[0].id,
        supplementId: supplementsDto[0].id,
        supplementName: supplementsDto[0].supplementName,
        classificationId: supplementsDto[0].classificationId,
        classificationName: classificationDto[0].name,
        scheduledDateTime: scheduledDateTime,
        completed: tasksDto[0].completed == 1 ? true : false,
        detail: tasksDto[0].details,
        repeatId: repeatsDto[0].id,
        repeatCode: repeatsDto[0].repeatCode,
        repeatTitle: repeatsDto[0].repeatTitle,
        dayOfWeek: repeatsDto[0].dayOfWeek,
        interval: repeatsDto[0].interval);

    return editTaskModel;
  }

  ///タスクの追加
  void insertTask() async {
    String createdDateTime = DateTimeCommon().createTimeStamp(DateTime.now());

    //予定日と予定時刻の分離
    List<String> scheduledDateTime = DateTimeCommon()
        .createDateTimeString(editTaskNotifierRead.scheduleDateTime);
    String scheduledDate = scheduledDateTime[0];
    String scheduledTime = scheduledDateTime[1];

    //サプリメントテーブル
    SupplementsTableService supplementsService = SupplementsTableService();
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
    int supplementsId = supplementsResult;

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
    int tasksResult = await tasksService.insertTaskTable(tasksDto);
  }

  ///タスクの更新
  void updateTask() async {
    String updatedDateTime = DateTimeCommon().createTimeStamp(DateTime.now());

    //予定日と予定時刻の分離
    List<String> scheduledDateTime = DateTimeCommon()
        .createDateTimeString(editTaskNotifierRead.scheduleDateTime);
    String scheduledDate = scheduledDateTime[0];
    String scheduledTime = scheduledDateTime[1];

    //サプリメントテーブル
    SupplementsTableService supplementsService = SupplementsTableService();
    //DTOの作成
    SupplementsDto supplementsDto = SupplementsDto(
        id: editTaskNotifierRead.supplementId,
        supplementName: editTaskNotifierRead.supplementName,
        classificationId: editTaskNotifierRead.classificationId,
        createdDateTime: '',
        updatedDateTime: updatedDateTime);

    //更新
    int supplementsResult =
        await supplementsService.updateSupplements(supplementsDto);

    //繰り返しテーブル
    RepeatsTableService repeatsService = RepeatsTableService();
    //DTOの作成
    RepeatsDto repeatsDto = RepeatsDto(
        id: editTaskNotifierRead.repeatId,
        repeatCode: editTaskNotifierRead.repeatCode,
        repeatTitle: editTaskNotifierRead.repeatTitle,
        dayOfWeek: editTaskNotifierRead.dayOfWeek,
        interval: editTaskNotifierRead.interval,
        createdDateTime: '',
        updatedDateTime: updatedDateTime);
    //insert
    int repeatsResult = await repeatsService.updateRepeats(repeatsDto);

    //タスクテーブル
    TasksTableService tasksService = TasksTableService();
    //DTOの作成
    TasksDto tasksDto = TasksDto(
        id: editTaskNotifierRead.taskId,
        supplementId: editTaskNotifierRead.supplementId,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        repeatId: editTaskNotifierRead.repeatId,
        details: editTaskNotifierRead.detail,
        completed: editTaskNotifierRead.completed == true ? 1 : 0,
        createdDateTime: '',
        updatedDateTime: updatedDateTime);
    //insert
    int tasksResult = await tasksService.updateTaskTable(tasksDto);
  }

  ///タスクの削除
  void deleteTask() async {
    //タスクテーブル
    TasksTableService tasksService = TasksTableService();
    //削除
    int tasksResult =
        await tasksService.deleteTaskTable(editTaskNotifierRead.taskId);

    //繰り返しテーブル
    RepeatsTableService repeatsService = RepeatsTableService();
    //削除
    int repeatsResult =
        await repeatsService.deleteRepeats(editTaskNotifierRead.repeatId);

    //サプリメントテーブル
    SupplementsTableService supplementsService = SupplementsTableService();
    //削除
    int supplementsResult = await supplementsService
        .deleteSupplements(editTaskNotifierRead.supplementId);
  }
}
