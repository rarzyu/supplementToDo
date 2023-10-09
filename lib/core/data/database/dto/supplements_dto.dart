///t_supplements サプリメントテーブル
class SupplementsDto {
  final int id;
  final String name;
  final int classificationId;
  final String createdDateTime;
  final String updatedDateTime;

  SupplementsDto({
    required this.id,
    required this.name,
    required this.classificationId,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  //データベースのMapからDTOを作成
  factory SupplementsDto.fromMap(Map<String, dynamic> map) {
    return SupplementsDto(
      id: map['id'],
      name: map['name'],
      classificationId: map['classification_id'],
      createdDateTime: map['created_date_time'],
      updatedDateTime: map['updated_date_time'],
    );
  }

  //DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'classification_id': classificationId,
      'created_date_time': createdDateTime,
      'updated_date_time': updatedDateTime,
    };
  }
}
