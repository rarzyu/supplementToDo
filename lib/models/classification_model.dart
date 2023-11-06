///分類マスタモデル
class ClassificationModel {
  ///ID
  int id;

  ///名前
  String name;

  ///削除フラグ
  ///True=削除／False=未削除
  bool deleted;

  ClassificationModel({
    required this.id,
    required this.name,
    required this.deleted,
  });
}
