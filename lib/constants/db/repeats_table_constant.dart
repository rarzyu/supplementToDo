/// 繰り返しテーブル
/// t_repeats
class RepeatsTableConstant {
  static const String tableName = 't_repeats';

  // 以下カラム
  static const String id = 'id';  // ID
  static const String repeatCode = 'repeat_code'; // 繰り返しコード
  static const String repeatTitle = 'repeat_title'; // 繰り返しタイトル
  static const String dayOfWeek = 'day_of_week';  // 選択した曜日
  static const String interval = 'interval';  // 繰り返し間隔（日数）
  static const String createdDateTime = 'created_date_time';  // 作成日時
  static const String updatedDateTime = 'updated_date_time';  // 更新日時
}
