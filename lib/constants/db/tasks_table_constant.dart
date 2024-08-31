/// タスクテーブル
/// t_tasks
class TasksTableConstant {
  static const String tableName = 't_tasks';

  // 以下カラム
  static const String id = 'id';  // ID
  static const String supplementId = 'supplement_id'; // サプリメントID
  static const String scheduledDate = 'scheduled_date'; // 服用予定日
  static const String scheduledTime = 'scheduled_time'; // 服用予定時刻
  static const String repeatId = 'repeat_id'; // 繰り返しID
  static const String details = 'details';  // 詳細
  static const String completed = 'completed';  // 完了フラグ
  static const String createdDateTime = 'created_date_time';  // 作成日時
  static const String updatedDateTime = 'updated_date_time';  // 更新日時
}
