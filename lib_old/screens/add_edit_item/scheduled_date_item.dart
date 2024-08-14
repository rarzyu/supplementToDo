import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/date_manager_notifier.dart';
import 'add_edit_section_title.dart';
import '../../widgets/month_calender_view.dart';

///服用予定日
class ScheduledDate extends StatelessWidget {
  final Icon icon =
      Icon(Icons.calendar_month_outlined, color: AppColors.fontBlackBold);
  final String title = '服用予定日';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AddEditSectionTitle(icon: icon, title: title),
          Center(
            child: ScheduledDateSelecter(),
          ),
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

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeBackGray,
            shadowColor: Colors.black),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Container(
                      width:
                          MediaQuery.of(context).size.width * 0.8, // 画面の80%の幅
                      height: MediaQuery.of(context).size.height *
                          0.50, // 画面の50%の高さ
                      child: CalendarView(),
                    ),
                  ));
        },
        child: Text(
          DateFormat('yyyy年MM月dd日（E）', 'ja_JP')
              .format(dateNotifierWatch.selectedDate),
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.fontBlackBold),
        ),
      ),
    );
  }
}
