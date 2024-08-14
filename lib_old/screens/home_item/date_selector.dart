import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/date_manager_notifier.dart';

///グローバル変数
const double itemWidth = 50; //アイテム横幅

///セクション全体
class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DateScroller(),
    );
  }
}

///日付スクロール部分
class DateScroller extends StatefulWidget {
  @override
  _DateScroller createState() => _DateScroller();
}

class _DateScroller extends State<DateScroller> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierWatch = context.watch<DateManagerNotifier>();
    final selectedDate = dateNotifierWatch.selectedDate;
    //前後1ヶ月だけスクロールで表示する
    final startDate =
        DateTime(selectedDate.year, selectedDate.month - 1, 1); //選択日の前月初め
    final endDate =
        DateTime(selectedDate.year, selectedDate.month + 2, 0); //選択日の翌月末
    final dayCount = endDate.difference(startDate).inDays; //上記の差分の日数

    return Container(
      height: 70,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: dayCount,
        itemBuilder: (context, index) {
          //日付にindexを加算
          final date = startDate.add(Duration(days: index));
          return DateButton(
            date: date,
            controller: _controller,
          );
        },
      ),
    );
  }

  //初期設定
  @override
  void initState() {
    super.initState();
    //選択日を中央にスクロール
    FunctionClass().CenterScroll(context, _controller, false);
  }
}

///日にちボタン部分
class DateButton extends StatelessWidget {
  final DateTime date;
  final ScrollController controller;
  const DateButton({Key? key, required this.date, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final dateNotifierWatch = context.watch<DateManagerNotifier>();
    final isSelected = dateNotifierWatch.selectedDate == date; //選択した日付かどうか

    return GestureDetector(
        //タップ領域をpaddingなども含めるようにする
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //日付をタップしたら、状態管理にその日付を格納
          dateNotifierRead.setSelectedDate(date);

          //選択日を中央にスクロール
          FunctionClass().CenterScroll(context, controller, true);
        },
        child: Container(
            width: itemWidth,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? AppColors.baseObjectDarkBlue
                      : AppColors.borderGray,
                  width: isSelected ? 3.5 : 1.5,
                ),
              ),
            ),
            child: Center(
                child: Column(
              children: [
                //日にち部分
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? AppColors.baseObjectDarkBlue
                        : AppColors.fontBlackBold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //曜日部分
                Text(
                  DateFormat('E', 'ja_JP').format(date),
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? AppColors.baseObjectDarkBlue
                        : AppColors.fontBlackBold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))));
  }
}

///このウィジェットの関数群
class FunctionClass {
  ///選択日を中央付近にスクロールする
  void CenterScroll(
      BuildContext context, ScrollController controller, bool isAnimation) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dateNotifierRead = context.read<DateManagerNotifier>();
      final selectedDate = dateNotifierRead.selectedDate;
      final startDate =
          DateTime(selectedDate.year, selectedDate.month - 1, 1); //選択日の前月初め
      int jumpCount = selectedDate.difference(startDate).inDays; //スクロールするアイテム数
      double jumpValue = jumpCount * itemWidth; //スクロールする量、アイテム数×1アイテムの幅
      double centerAdjust = 3.4 * itemWidth; //真ん中に調整するための補正、補正倍率×1アイテムの幅

      //スクロールする量-補正幅
      //引数のフラグで変化
      if (isAnimation) {
        controller.animateTo(jumpValue - centerAdjust,
            duration: Duration(milliseconds: 300), //移動するのに要する時間（ミリ秒）
            curve: Curves.ease);
      } else {
        controller.jumpTo(jumpValue - centerAdjust);
      }
    });
  }
}
