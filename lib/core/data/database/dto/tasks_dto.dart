///t_tasks タスクテーブル
class SupplementsDto {
  final int id; //ID
  final int supplementId; //サプリメントID
  final String scheduledDate; //服用予定日
  final String scheduledTime; //服用予定時刻
  final String details; //詳細
  final int completed; //完了フラグ
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  SupplementsDto({
    required this.id,
    required this.supplementId,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.details,
    required this.completed,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  // データベースのMapからDTOを作成
  factory SupplementsDto.fromMap(Map<String, dynamic> map) {
    return SupplementsDto(
      id: map['id'],
      supplementId: map['sapplement_id'],
      scheduledDate: map['scheduled_date'],
      scheduledTime: map['scheduled_time'],
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
      'details': details,
      'completed': completed,
      'created_date_time': createdDateTime,
      'updated_date_time': updatedDateTime,
    };
  }
}
