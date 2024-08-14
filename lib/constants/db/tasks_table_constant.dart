///タスクテーブルの定数定義
class TasksTableConstant {
  ///テーブル名
  static const String tableName = 't_tasks';

  //以下カラム
  ///ID
  static const String id = 'id';

  ///サプリメントID
  static const String supplementId = 'supplement_id';

  ///服用予定日
  static const String scheduledDate = 'scheduled_date';

  ///服用予定日
  static const String scheduledTime = 'scheduled_time';

  ///繰り返しID
  static const String repeatId = 'repeat_id';

  ///詳細
  static const String details = 'details';

  ///完了フラグ
  static const String completed = 'completed';

  ///作成日時
  static const String createdDateTime = 'created_date_time';

  ///更新日時
  static const String updatedDateTime = 'updated_date_time';
}
