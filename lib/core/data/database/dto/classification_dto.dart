///m_classification 分類管理マスタ
class ClassificationModel {
  final int id; //ID
  final String name; //分類名
  final int deleted; //削除フラグ
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  ClassificationModel({
    required this.id,
    required this.name,
    required this.deleted,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  factory ClassificationModel.fromMap(Map<String, dynamic> map) {
    return ClassificationModel(
      id: map['id'],
      name: map['name'],
      deleted: map['deleted'],
      createdDateTime: map['created_date_time'],
      updatedDateTime: map['updated_date_time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'deleted': deleted,
      'created_date_time': createdDateTime,
      'updated_date_time': updatedDateTime,
    };
  }
}
