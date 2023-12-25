import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import 'add_edit_section_title.dart';

///このファイル内共通定数
///セグメントコントロールのテキスト
const String SEGMENT_1 = '毎日';
const String SEGMENT_2 = '曜日ごと';
const String SEGMENT_3 = '日数ごと';

///繰り返しコード
///enumを使いたいが、switchで使えないため
const int REPEAT_CODE_EVERYDAY = 1;
const int REPEAT_CODE_WEEKDAYS = 2;
const int REPEAT_CODE_DAYS = 3;

///曜日
final List<String> weekDays = ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'];

///曜日（頭文字だけ）
final List<String> weekDaysShort = ['日', '月', '火', '水', '木', '金', '土'];

///繰り返し選択
class Repeat extends StatelessWidget {
  final Icon icon = Icon(Icons.repeat, color: AppColors.fontBlackBold);
  final String title = '繰り返し';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AddEditSectionTitle(icon: icon, title: title),
          RepeatSelectButton(),
        ],
      ),
    );
  }
}

///ボタン
class RepeatSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();

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
              builder: (BuildContext buildContext) {
                return Dialog(
                  child: RepeatIntervalSelection(
                    editTaskNotifierWatch: editTaskNotifierWatch,
                  ),
                );
              });
        },
        child: Text(
          editTaskNotifierWatch.repeatTitle == ''
              ? '繰り返しを設定'
              : editTaskNotifierWatch.repeatTitle,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.fontBlackBold),
        ),
      ),
    );
  }
}

///繰り返し選択ダイアログ
class RepeatIntervalSelection extends StatefulWidget {
  final EditTaskNotifier editTaskNotifierWatch;

  RepeatIntervalSelection({
    Key? key,
    required this.editTaskNotifierWatch,
  }) : super(key: key);

  @override
  _RepeatIntervalSelectionState createState() =>
      _RepeatIntervalSelectionState();

  //選択しているセグメントのタイトル
  String selectedSegmentTitle() {
    switch (editTaskNotifierWatch.repeatCode) {
      //毎日
      case REPEAT_CODE_EVERYDAY:
        return SEGMENT_1;

      //曜日ごと
      case REPEAT_CODE_WEEKDAYS:
        return SEGMENT_2;

      //日数ごと
      case REPEAT_CODE_DAYS:
        return SEGMENT_3;

      default:
        return SEGMENT_1;
    }
  }

  //句点区切りの曜日から選択されている曜日の配列に変換する
  List<bool> ChangeWeekdaysSelected() {
    List<bool> _res = [];
    List<String> selectedWeekdays = editTaskNotifierWatch.dayOfWeek.split('、');

    for (int i = 0; i < weekDaysShort.length; i++) {
      bool checkResult = selectedWeekdays.contains(weekDaysShort[i]);
      _res.add(checkResult);
    }

    return _res;
  }

  //入力されている日付
  String inputDay() {
    return editTaskNotifierWatch.interval.toString() == '0'
        ? ''
        : editTaskNotifierWatch.interval.toString();
  }
}

class _RepeatIntervalSelectionState extends State<RepeatIntervalSelection> {
  late String selectedSegment;
  late List<bool> weekdaysSelected;
  late String dayText;
  TextEditingController dayCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedSegment = widget.selectedSegmentTitle();
    weekdaysSelected = widget.ChangeWeekdaysSelected();
    dayText = widget.inputDay();
    dayCountController = TextEditingController(text: dayText);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          //セグメンテッドコントロール
          CupertinoSegmentedControl(
            borderColor: AppColors.baseObjectDarkBlue,
            selectedColor: AppColors.baseObjectDarkBlue,
            children: {
              SEGMENT_1: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(SEGMENT_1),
              ),
              SEGMENT_2: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(SEGMENT_2),
              ),
              SEGMENT_3: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(SEGMENT_3),
              ),
            },
            onValueChanged: (value) {
              setState(() {
                selectedSegment = value;
              });
            },
            groupValue: selectedSegment.isEmpty ? SEGMENT_1 : selectedSegment,
          ),
          SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: Center(
              child: selectSegmentDetail(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(
            color: AppColors.borderGray,
            thickness: 1,
          ),
          //完了ボタン
          TextButton(
              onPressed: () {
                //モデルに格納する
                RepeatSetClass(
                  context: context,
                  selectSegment: selectedSegment,
                  selectedWeekDays: weekdaysSelected,
                  dayTextController: dayCountController,
                ).SetRepeatModel();
                Navigator.pop(context);
              },
              child: Text('完了',
                  style: TextStyle(
                      color: AppColors.baseObjectDarkBlue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }

  ///選択したセグメントに応じて、 適したウィジェットを返す
  Widget selectSegmentDetail() {
    switch (selectedSegment) {
      //毎日
      case SEGMENT_1:
        return Text('毎日繰り返します');

      //曜日ごと
      case SEGMENT_2:
        return ListView(
          children: [
            ...List.generate(7, (index) {
              return CheckboxListTile(
                title: Text(weekDays[index]),
                value: weekdaysSelected[index],
                onChanged: (bool? value) {
                  setState(() {
                    weekdaysSelected[index] = value!;
                  });
                },
              );
            }),
          ],
        );

      //日数ごと
      case SEGMENT_3:
        return Container(
          child: Column(
            children: [
              Text('日数を入力して下さい'),
              Text('例）2 = 2日ごとに繰り返します'),
              TextField(
                controller: dayCountController,
                decoration: InputDecoration(labelText: '日数を入力'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }
}

///繰り返しの各種設定
class RepeatSetClass {
  final BuildContext context;
  final String selectSegment;
  final List<bool> selectedWeekDays;
  final TextEditingController dayTextController;

  RepeatSetClass({
    required this.context,
    required this.selectSegment,
    required this.selectedWeekDays,
    required this.dayTextController,
  });

  ///モデルに格納する
  void SetRepeatModel() {
    //状態管理
    final editTaskNotifierRead = context.read<EditTaskNotifier>();

    List<String> selectedWeekdaysShort = [];
    String repeatTitle = '';
    int repeatCode = 0;
    int inputDay = 0;

    //セグメントごとに、必要な変数を設定する
    switch (selectSegment) {
      //毎日
      case SEGMENT_1:
        repeatCode = REPEAT_CODE_EVERYDAY;
        repeatTitle = SEGMENT_1;
        break;

      //曜日ごと
      case SEGMENT_2:
        repeatCode = REPEAT_CODE_WEEKDAYS;
        //指定した曜日を配列に
        for (int i = 0; i < selectedWeekDays.length; i++) {
          if (selectedWeekDays[i]) {
            selectedWeekdaysShort.add(weekDaysShort[i]);
          }
        }

        //すべての曜日を選択していた場合は毎日に切り替える
        if (selectedWeekdaysShort.length == 7) {
          repeatCode = REPEAT_CODE_EVERYDAY;
          repeatTitle = SEGMENT_1;
          selectedWeekdaysShort = [];
          break;
        }

        if (selectedWeekdaysShort.isNotEmpty) {
          repeatTitle = '毎週: ' + selectedWeekdaysShort.join('、');
        }

        break;

      //日数ごと
      case SEGMENT_3:
        repeatCode = REPEAT_CODE_DAYS;

        //入力がない or 0の場合
        if (dayTextController.text.isEmpty || dayTextController.text == '0') {
          inputDay = 0;
          repeatTitle = '';

          //入力されている場合
        } else {
          inputDay = int.parse(dayTextController.text);
          repeatTitle = dayTextController.text + '日ごと';
        }
        break;

      //未選択など
      default:
        repeatCode = 0;
        repeatTitle = SEGMENT_1;
    }

    //格納
    //繰り返しコード
    editTaskNotifierRead.setRepeatCode(repeatCode);
    //繰り返しタイトル
    editTaskNotifierRead.setRepeatTitle(repeatTitle);
    //選択した曜日
    editTaskNotifierRead.setDayOfWeek(selectedWeekdaysShort.join('、'));
    //入力した日数
    editTaskNotifierRead.setInterval(inputDay);
  }
}
