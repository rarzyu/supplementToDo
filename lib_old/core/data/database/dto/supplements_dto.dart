import '../../../../config/constants/db/supplements_table_constants.dart';

///t_supplements サプリメントテーブル
class SupplementsDto {
  final int id;
  final String supplementName;
  final int classificationId;
  final String createdDateTime;
  final String updatedDateTime;

  SupplementsDto({
    required this.id,
    required this.supplementName,
    required this.classificationId,
    required this.createdDateTime,
    required this.updatedDateTime,
  });

  ///データベースのMapからDTOを作成
  factory SupplementsDto.fromMap(Map<String, dynamic> map) {
    return SupplementsDto(
      id: map[SupplementsTableConstants.id],
      supplementName: map[SupplementsTableConstants.supplementName],
      classificationId: map[SupplementsTableConstants.classificationId],
      createdDateTime: map[SupplementsTableConstants.createdDateTime],
      updatedDateTime: map[SupplementsTableConstants.updatedDateTime],
    );
  }

  ///DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      SupplementsTableConstants.id: id,
      SupplementsTableConstants.supplementName: supplementName,
      SupplementsTableConstants.classificationId: classificationId,
      SupplementsTableConstants.createdDateTime: createdDateTime,
      SupplementsTableConstants.updatedDateTime: updatedDateTime,
    };
  }

  ///DTOからデータベースのMapを作成
  ///INSERT用、IDをなくしている
  Map<String, dynamic> toMapNoId() {
    return {
      SupplementsTableConstants.supplementName: supplementName,
      SupplementsTableConstants.classificationId: classificationId,
      SupplementsTableConstants.createdDateTime: createdDateTime,
      SupplementsTableConstants.updatedDateTime: updatedDateTime,
    };
  }

  ///DTOからデータベースのMapを作成
  ///UPDATE用、CreateDateTimeをなくしている
  Map<String, dynamic> toMapNoCreateDateTime() {
    return {
      SupplementsTableConstants.id: id,
      SupplementsTableConstants.supplementName: supplementName,
      SupplementsTableConstants.classificationId: classificationId,
      SupplementsTableConstants.updatedDateTime: updatedDateTime,
    };
  }
}
