import 'package:supplement_to_do/config/constants/db/repeats_table_constants.dart';

///t_repeat 繰り返しテーブル
class RepeatsDto {
  final int id; //ID
  final int repeatCode; //繰り返しコード
  final String repeatTitle; //繰り返しのタイトル
  final String dayOfWeek; //選択した曜日
  final int interval; //繰り返し間隔（日数）
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  RepeatsDto(
      {required this.id,
      required this.repeatCode,
      required this.repeatTitle,
      required this.dayOfWeek,
      required this.interval,
      required this.createdDateTime,
      required this.updatedDateTime});

  // データベースのMapからDTOを作成
  factory RepeatsDto.fromMap(Map<String, dynamic> map) {
    return RepeatsDto(
      id: map[RepeatsTableConstants.id],
      repeatCode: map[RepeatsTableConstants.repeatCode],
      repeatTitle: map[RepeatsTableConstants.repeatTitle],
      dayOfWeek: map[RepeatsTableConstants.dayOfWeek],
      interval: map[RepeatsTableConstants.interval],
      createdDateTime: map[RepeatsTableConstants.createdDateTime],
      updatedDateTime: map[RepeatsTableConstants.updatedDateTime],
    );
  }

  // DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      RepeatsTableConstants.id: id,
      RepeatsTableConstants.repeatCode: repeatCode,
      RepeatsTableConstants.repeatTitle: repeatTitle,
      RepeatsTableConstants.dayOfWeek: dayOfWeek,
      RepeatsTableConstants.interval: interval,
      RepeatsTableConstants.createdDateTime: createdDateTime,
      RepeatsTableConstants.updatedDateTime: updatedDateTime,
    };
  }
}
