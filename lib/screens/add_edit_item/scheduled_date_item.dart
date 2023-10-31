import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/widgets/month_calender_view.dart';
import '../../providers/date_manager_notifier.dart';
import '../../providers/edit_task_notifier.dart';

///服用予定日
class ScheduledDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ScheduledDateTitle(),
          Center(
            child: ScheduledDateSelecter(),
          ),
        ],
      ),
    );
  }
}

///タイトル部分
class ScheduledDateTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.borderGray,
      child: Row(
        children: [
          Icon(Icons.calendar_month_outlined, color: AppColors.fontBlackBorder),
          Text('服用予定日')
        ],
      ),
    );
  }
}

///日付選択部分
class ScheduledDateSelecter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierWatch = context.watch<DateManagerNotifier>();
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeBackGray, shadowColor: Colors.black),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8, // 画面の80%の幅
                    height:
                        MediaQuery.of(context).size.height * 0.45, // 画面の45%の高さ
                    child: CalendarView(),
                  ),
                ));
      },
      child: Text(
        DateFormat('yyyy/MM/dd').format(dateNotifierWatch.selectedDate),
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.fontBlackBorder),
      ),
    );
  }
}
