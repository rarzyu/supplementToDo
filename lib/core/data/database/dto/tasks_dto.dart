import 'package:supplement_to_do/config/constants/db/tasks_table_constants.dart';

///t_tasks タスクテーブル
class TasksDto {
  final int id; //ID
  final int supplementId; //サプリメントID
  final String scheduledDate; //服用予定日
  final String scheduledTime; //服用予定時刻
  final int repeatId; //繰り返しID
  final String details; //詳細
  final int completed; //完了フラグ
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  TasksDto({
    required this.id,
    required this.supplementId,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.repeatId,
    required this.details,
    required this.completed,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  ///データベースのMapからDTOを作成
  factory TasksDto.fromMap(Map<String, dynamic> map) {
    return TasksDto(
      id: map[TasksTableConstants.id],
      supplementId: map[TasksTableConstants.supplementId],
      scheduledDate: map[TasksTableConstants.scheduledDate],
      scheduledTime: map[TasksTableConstants.scheduledTime],
      repeatId: map[TasksTableConstants.repeatId],
      details: map[TasksTableConstants.details],
      completed: map[TasksTableConstants.completed],
      createdDateTime: map[TasksTableConstants.createdDateTime],
      updatedDateTime: map[TasksTableConstants.updatedDateTime],
    );
  }

  ///DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      TasksTableConstants.id: id,
      TasksTableConstants.supplementId: supplementId,
      TasksTableConstants.scheduledDate: scheduledDate,
      TasksTableConstants.scheduledTime: scheduledTime,
      TasksTableConstants.repeatId: repeatId,
      TasksTableConstants.details: details,
      TasksTableConstants.completed: completed,
      TasksTableConstants.createdDateTime: createdDateTime,
      TasksTableConstants.updatedDateTime: updatedDateTime,
    };
  }
}
