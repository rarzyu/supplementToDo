import 'package:intl/intl.dart';

///日付・時刻に関する共通関数
class DateTimeCommon {
  ///タイムスタンプを返却する
  ///yyyyMMddHHmmss形式で返却する
  String createTimeStamp(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    return formatter.format(dateTime);
  }

  ///日付＋時刻を1つのDateTime型で返却する
  ///引数
  ///date: yyyy-MM-dd
  ///time: HH:mm:ss
  DateTime createDateTime(String date, String time) {
    String dateTime = date + ' ' + time;
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.parse(dateTime);
  }

  ///日付＋時刻をそれぞれのString型で返却する
  ///戻り値
  ///date: yyyy-MM-dd（０番目）
  ///time: HH:mm:ss（１番目）
  List<String> createDateTimeString(DateTime dateTime) {
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    String time = DateFormat('HH:mm:ss').format(dateTime);
    return [date, time];
  }
}
