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

  // データベースのMapからDTOを作成
  factory TasksDto.fromMap(Map<String, dynamic> map) {
    return TasksDto(
      id: map['id'],
      supplementId: map['sapplement_id'],
      scheduledDate: map['scheduled_date'],
      scheduledTime: map['scheduled_time'],
      repeatId: map['repeat_id'],
      details: map['details'],
      completed: map['completed'],
      createdDateTime: map['created_date_time'],
      updatedDateTime: map['updated_date_time'],
    );
  }

  // DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sapplement_id': supplementId,
      'scheduled_date': scheduledDate,
      'scheduled_time': scheduledTime,
      'repeat_id': repeatId,
      'details': details,
      'completed': completed,
      'created_date_time': createdDateTime,
      'updated_date_time': updatedDateTime,
    };
  }
}
