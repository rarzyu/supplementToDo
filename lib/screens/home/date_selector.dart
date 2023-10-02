/// 日付選択部分

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';

import '../../providers/date_manager_notifier.dart';

/// セクション全体
class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DateScroller(),
    );
  }
}

/// 日付スクロール部分
class DateScroller extends StatefulWidget {
  @override
  _DateScroller createState() => _DateScroller();
}

class _DateScroller extends State<DateScroller> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // 状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final selectedDate = dateNotifierRead.selectedDate;
    // 前後1ヶ月だけスクロールで表示する
    final startDate =
        DateTime(selectedDate.year, selectedDate.month - 1, 1); // 選択日の前月初め
    final endDate =
        DateTime(selectedDate.year, selectedDate.month + 2, 0); // 選択日の翌月末
    final dayCount = endDate.difference(startDate).inDays; // 上記の差分の日数

    return Container(
      height: 70,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: dayCount,
        itemBuilder: (context, index) {
          // 日付にindexを加算
          final date = startDate.add(Duration(days: index));
          return DateButton(date: date);
        },
      ),
    );
  }

  // 初期設定
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dateNotifierRead = context.read<DateManagerNotifier>();
      final selectedDate = dateNotifierRead.selectedDate;
      final startDate =
          DateTime(selectedDate.year, selectedDate.month - 1, 1); // 選択日の前月初め
      int jumpCount = selectedDate.difference(startDate).inDays;
      _controller.jumpTo((jumpCount * 50) -
          (3.3 * 50)); // 下記で定義している日にちのContainerの横幅 - 真ん中に持ってくるので3.3個分左にずらす
    });
  }
}

/// 日にちボタン部分
class DateButton extends StatelessWidget {
  final DateTime date;
  const DateButton({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final dateNotifierWatch = context.watch<DateManagerNotifier>();
    final isSelected = dateNotifierWatch.selectedDate == date; // 選択した日付かどうか

    return GestureDetector(
        // タップ領域をpaddingなども含めるようにする
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 日付をタップしたら、状態管理にその日付を格納
          dateNotifierRead.setSelectedDate(date);
          dateNotifierRead.setDisplayedYearMonth(date);
        },
        child: Container(
            width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.borderGray,
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
                child: Column(
              children: [
                // 日にち部分
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? AppColors.baseObjectDarkBlue
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // 曜日部分
                Text(
                  DateFormat('E', 'ja_JP').format(date),
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? AppColors.baseObjectDarkBlue
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))));
  }
}
