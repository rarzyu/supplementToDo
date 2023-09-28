/// 日付選択部分

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  /// TODO:まずは、選択している月の1ヶ月分の日にちを1日〜末日で表示させる
  /// また、30日固定ではなく、月末が可変するようにアイテム数は計算する
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 60,
        itemBuilder: (context, index) {
          // 日付にindexを加算
          final date = DateTime(DateTime.now().year, DateTime.now().month, 1)
              .add(Duration(days: index));
          return GestureDetector(
              onTap: () {
                // タップした日付の処理をここに記述
                print('Tapped on ${date.toLocal()}');
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(DateFormat('E', 'ja_JP').format(date)),
                    ],
                  ))));
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 初期位置を今日の日付に設定（オプション）
    Future.delayed(Duration.zero, () {
      _controller.jumpTo(50.0 * DateTime.now().day);
    });
  }
}
