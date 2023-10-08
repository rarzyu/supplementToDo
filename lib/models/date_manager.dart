/// 日付管理

class DateManager {
  DateTime selectedDate; // 選択された日付

  final minDate = DateTime(DateTime.now().year - 2, 1, 1); // 最小は2年前の1月1日
  final maxDate = DateTime(DateTime.now().year + 2, 12, 31); //　最大は2年後の12月31日

  DateManager({required this.selectedDate});
}
