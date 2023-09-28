/// 画面最上位部分
/// 年月選択と新規追加ボタンの部分

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:supplement_to_do/screens/add_edit/add_edit_screen.dart';
import 'package:intl/intl.dart';

/// セクション全体
class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.0),
            child: YearMonthSelect(),
          ),
          Padding(
              padding: EdgeInsets.only(right: 9.0),
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AddEditScreen(index: 0);
                      }),
                    );
                  },
                  child: Icon(Icons.add)))
        ],
      ),
    );
  }
}

///年月選択ボタン群
///ドラムロールの定義
class YearMonthModel extends DatePickerModel {
  YearMonthModel(
      {required DateTime currentTime,
      required DateTime minTime,
      required DateTime maxTime,
      required LocaleType locale})
      : super(
            locale: locale,
            minTime: minTime,
            maxTime: maxTime,
            currentTime: currentTime);

  @override
  List<int> layoutProportions() {
    return [1, 1, 0]; // ここで年月のみに指定
  }
}

/// 年月選択ドラムロールとそのボタン
class YearMonthSelect extends StatefulWidget {
  @override
  _YearMonthSelect createState() => _YearMonthSelect();
}

class _YearMonthSelect extends State<YearMonthSelect> {
  late String yearMonth;
  late DateTime dateTime;
  final minDate = DateTime(DateTime.now().year - 2, 1, 1); // 最小は2年前の1月1日
  final maxDate = DateTime(DateTime.now().year + 2, 12, 31); //　最大は2年後の12月31日

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    yearMonth = DateFormat('yyyy年M月').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          DatePicker.showPicker(
            context,
            showTitleActions: true,
            locale: LocaleType.jp,
            pickerModel: YearMonthModel(
                currentTime: dateTime,
                minTime: minDate,
                maxTime: maxDate,
                locale: LocaleType.jp),
            onConfirm: (date) {
              setState(() {
                dateTime = date;
                yearMonth = DateFormat('yyyy年M月').format(date);
              });
            },
          );
        },
        child: Text(yearMonth));
  }
}
