import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../lib/providers/date_manager_notifier.dart';

/// カレンダービュー
class MonthCalenderComponent extends StatefulWidget {
  @override
  _MonthCalenderComponentState createState() => _MonthCalenderComponentState();
}

class _MonthCalenderComponentState extends State<MonthCalenderComponent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierWatch = context.watch<DateManagerNotifier>();
    final dateNotifierRead = context.read<DateManagerNotifier>();

    DateTime forcusDate = dateNotifierWatch.selectedDate;

    return TableCalendar(
      firstDay: dateNotifierWatch.minDate,
      lastDay: dateNotifierWatch.maxDate,
      focusedDay: forcusDate,
      calendarFormat: _calendarFormat,
      locale: 'ja_JP',
      daysOfWeekHeight: 24.0,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month', //表示形式を月表示のみに
      },

      //以下アクション
      selectedDayPredicate: (day) {
        return isSameDay(dateNotifierWatch.selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          dateNotifierRead.setSelectedDate(selectedDay);
          forcusDate = focusedDay;
          Navigator.pop(context); //カレンダーを閉じる
        });
      },
      onPageChanged: (focusedDay) {
        forcusDate = focusedDay;
      },
    );
  }
}
