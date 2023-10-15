///t_repeat 繰り返しテーブル
class RepeatsDto {
  final int id; //ID
  final int repeatCode; //繰り返しコード
  final String dayOfWeek; //選択した曜日
  final int interval; //繰り返し間隔（日数）
  final String createdDateTime; //作成日時
  final String updatedDateTime; //更新日時

  RepeatsDto(
      {required this.id,
      required this.repeatCode,
      required this.dayOfWeek,
      required this.interval,
      required this.createdDateTime,
      required this.updatedDateTime});

  // データベースのMapからDTOを作成
  factory RepeatsDto.fromMap(Map<String, dynamic> map) {
    return RepeatsDto(
      id: map['id'],
      repeatCode: map['repeat_code'],
      dayOfWeek: map['day_of_week'],
      interval: map['interval'],
      createdDateTime: map['created_date_time'],
      updatedDateTime: map['updated_date_time'],
    );
  }

  // DTOからデータベースのMapを作成
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'repeat_code': repeatCode,
      'day_of_week': dayOfWeek,
      'interval': interval,
      'created_date_time': createdDateTime,
      'updated_date_time': updatedDateTime,
    };
  }
}
