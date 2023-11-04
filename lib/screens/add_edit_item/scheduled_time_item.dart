import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import '../../widgets/month_calender_view.dart';

///服用予定時刻
class SheduledTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ScheduledTimeTitle(),
          ScheduledTimeSelector(),
        ],
      ),
    );
  }
}

///タイトル部分
class ScheduledTimeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.borderGray,
      child: Row(
        children: [
          Icon(Icons.watch_later_outlined, color: AppColors.fontBlackBorder),
          Text('服用予定時刻')
        ],
      ),
    );
  }
}

///時刻選択部分
class ScheduledTimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeBackGray, shadowColor: Colors.black),
      onPressed: () {
        _selectTime(context, editTaskNotifierWatch, editTaskNotifierRead);
      },
      child: Text(
        DateFormat('H時mm分').format(editTaskNotifierWatch.scheduleDateTime),
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.fontBlackBorder),
      ),
    );
  }
}

///時刻選択ピッカー
Future<void> _selectTime(
    BuildContext context,
    EditTaskNotifier editTaskNotifierWatch,
    EditTaskNotifier editTaskNotifierRead) async {
  //ピッカーの初期時刻
  TimeOfDay initTime = TimeOfDay(
      hour: editTaskNotifierWatch.scheduleDateTime.hour,
      minute: editTaskNotifierWatch.scheduleDateTime.minute);

  //0時0分の場合、現在時刻を設定
  //※0時0分をユーザーが設定した場合も現在時刻が設定されてしまうが、これは見逃すことに
  if (initTime.hour == 0 && initTime.minute == 0) {
    initTime = TimeOfDay.now();
  }

  var selectedTime = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Localizations.override(
              context: context,
              locale: const Locale('ja', 'JP'), // 日本語を強制
              child: child!,
            ));
      });

  if (selectedTime != null) {
    //現在の日時
    DateTime scheduledDateTime = editTaskNotifierWatch.scheduleDateTime;
    //新しい日時
    DateTime newDateTime = DateTime(
      scheduledDateTime.year,
      scheduledDateTime.month,
      scheduledDateTime.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    //選択した日時をセットする
    editTaskNotifierRead.setScheduleDateTime(newDateTime);
  }
}
