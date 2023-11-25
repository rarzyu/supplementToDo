import 'package:supplement_to_do/config/constants/db/classification_master_constants.dart';

///m_classification 分類管理マスタ
class ClassificationDto {
  final int id; //ID
  final String name; //分類名
  final int deleted; //削除フラグ
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  ClassificationDto({
    required this.id,
    required this.name,
    required this.deleted,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  //データベースのMapからDTOを作成
  factory ClassificationDto.fromMap(Map<String, dynamic> map) {
    return ClassificationDto(
      id: map[ClassificationMasterConstants.id],
      name: map[ClassificationMasterConstants.name],
      deleted: map[ClassificationMasterConstants.deleted],
      createdDateTime: map[ClassificationMasterConstants.createdDateTime],
      updatedDateTime: map[ClassificationMasterConstants.updatedDateTime],
    );
  }

  //DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      ClassificationMasterConstants.id: id,
      ClassificationMasterConstants.name: name,
      ClassificationMasterConstants.deleted: deleted,
      ClassificationMasterConstants.createdDateTime: createdDateTime,
      ClassificationMasterConstants.updatedDateTime: updatedDateTime,
    };
  }
}
