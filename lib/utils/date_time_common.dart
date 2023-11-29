import 'package:intl/intl.dart';

///日付・時刻に関する共通関数
class DateTimeCommon {
  ///タイムスタンプを返却する
  ///yyyyMMddHHmmss形式で返却する
  String createTimeStamp(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    return formatter.format(dateTime);
  }
}
