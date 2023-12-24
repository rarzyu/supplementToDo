///画面最上位部分
///年月選択と新規追加ボタンの部分

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/providers/date_manager_notifier.dart';
import 'package:supplement_to_do/screens/add_edit_screen.dart';
import 'package:intl/intl.dart';
import 'package:supplement_to_do/services/ad_manager.dart';
import '../../providers/edit_task_notifier.dart';

///セクション全体
class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //年月選択ボタン
          Padding(
            padding: EdgeInsets.only(left: 9.0),
            child: YearMonthSelect(),
          ),
          //新規追加ボタン
          Padding(padding: EdgeInsets.only(right: 9.0), child: TaskAddButton())
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
    return [1, 1, 0]; //ここで年月のみに指定
  }
}

///年月選択ドラムロールとそのボタン
class YearMonthSelect extends StatefulWidget {
  @override
  _YearMonthSelect createState() => _YearMonthSelect();
}

class _YearMonthSelect extends State<YearMonthSelect> {
  late String yearMonth;
  late DateTime dateTime;
  final minDate = DateTime(DateTime.now().year - 2, 1, 1); //最小は2年前の1月1日
  final maxDate = DateTime(DateTime.now().year + 2, 12, 31); //　最大は2年後の12月31日

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    yearMonth = DateFormat('yyyy年M月').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierRead = context.read<DateManagerNotifier>();
    final dateNotifierWatch = context.watch<DateManagerNotifier>();

    //状態管理から日付を取得
    dateTime = dateNotifierWatch.selectedDate;
    yearMonth = DateFormat('yyyy年M月').format(dateNotifierWatch.selectedDate);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeBackGray,
            shadowColor: Colors.black),
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

                //状態管理に渡す
                dateNotifierRead.setSelectedDate(dateTime);
              });
            },
          );
        },
        child: Row(
          children: [
            Text(
              yearMonth,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.fontBlackBold),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.fontBlackBold,
            )
          ],
        ));
  }
}

///新規追加ボタン
class TaskAddButton extends StatelessWidget {
  AdManager? adManager;

  TaskAddButton() {
    adManager = AdManager();
  }

  dispose() {
    adManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();
    final dateNotifierRead = context.read<DateManagerNotifier>();

    return FloatingActionButton(
        backgroundColor: AppColors.baseObjectDarkBlue,
        //角丸四角に変更
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        onPressed: () {
          //modelを初期化する
          //フラグもfalseがセットされるので追加モードになる
          editTaskNotifierRead.resetAll();

          DateTime scheduleDateTime = dateNotifierRead.selectedDate;
          //現在時刻を追加
          scheduleDateTime = scheduleDateTime.add(Duration(
              hours: DateTime.now().hour, minutes: DateTime.now().minute));

          //日付を状態管理に渡す
          editTaskNotifierRead.setScheduleDateTime(scheduleDateTime);

          adManager!.showInterstitialAd();

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddEditScreen();
            }),
          );
        },
        child: Icon(Icons.add));
  }
}
