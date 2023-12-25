///基礎タスクModel
class BaseTaskModel {
  ///タスクID
  int taskId;

  ///サプリメントID
  int supplementId;

  ///サプリメント名
  ///つまり、タスクタイトル
  String supplementName;

  ///分類ID
  int classificationId;

  ///分類名
  String classificationName;

  ///服用予定日時
  ///DBでは時刻と日付は別だが、日付型にするため統一する
  DateTime scheduledDateTime;

  ///完了フラグ
  ///True=完了／False=未完了
  bool completed;

  BaseTaskModel({
    required this.taskId,
    required this.supplementId,
    required this.supplementName,
    required this.classificationId,
    required this.classificationName,
    required this.scheduledDateTime,
    required this.completed,
  });
}
