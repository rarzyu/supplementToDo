/// 画面最上位部分
/// 年月選択と新規追加ボタンの部分

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:supplement_to_do/screens/add_edit/add_edit_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// セクション全体
class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Row(
        children: [
          YearMonthSelect(),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return AddEditScreen(index: 0);
                  }),
                );
              },
              icon: Icon(Icons.add))
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
    return [1, 1, 0];
  }
}

/// 年月選択ドラムロールとそのボタン
class YearMonthSelect extends StatefulWidget {
  @override
  State<YearMonthSelect> createState() => _YearMonthSelect();
}

class _YearMonthSelect extends State<YearMonthSelect> {
  late String yearMonth;
  late DateTime dateTime;

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
                minTime: DateTime(2022, 1, 1),
                maxTime: DateTime(2023, 12, 31),
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
