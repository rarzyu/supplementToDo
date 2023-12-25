import 'package:supplement_to_do/models/base_task_model.dart';

///追加・編集用のタスクModel
class EditTaskModel extends BaseTaskModel {
  ///編集モードかどうか
  ///True=編集／False=追加
  bool isEditMode;

  ///詳細
  String detail;

  ///繰り返しID
  int repeatId;

  ///繰り返しコード
  int repeatCode;

  ///繰り返しタイトル
  String repeatTitle;

  ///選択した曜日
  String dayOfWeek;

  ///繰り返し間隔（日数）
  int interval;

  EditTaskModel({
    //継承元
    required int taskId,
    required int supplementId,
    required String supplementName,
    required int classificationId,
    required String classificationName,
    required DateTime scheduledDateTime,
    required bool completed,

    //このモデル部分
    required this.isEditMode,
    required this.detail,
    required this.repeatId,
    required this.repeatCode,
    required this.repeatTitle,
    required this.dayOfWeek,
    required this.interval,
  }) : super(
          taskId: taskId,
          supplementId: supplementId,
          supplementName: supplementName,
          classificationId: classificationId,
          classificationName: classificationName,
          scheduledDateTime: scheduledDateTime,
          completed: completed,
        );
}
