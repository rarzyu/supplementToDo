import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import 'package:supplement_to_do/screens/add_edit/add_edit_screen.dart';
import '../../providers/date_manager_notifier.dart';

///タスク一覧セクション
///セクション全体
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final dateNotifierWatch = context.watch<DateManagerNotifier>();

    return Expanded(
      child: ListView.builder(
          itemCount: 1000,
          itemBuilder: (context, index) => ListItem(
                index: index,
                selectedDate: dateNotifierWatch.selectedDate,
              )),
    );
  }
}

///リストのアイテム
class ListItem extends StatelessWidget {
  final int index;
  final DateTime selectedDate;
  const ListItem({Key? key, required this.index, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //タップ領域をpaddingなども含めるようにする
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddEditScreen(index: index);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderGray,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //チェックボックス
              SizedBox(
                child: TaskCheckBox(),
              ),
              //タスク名
              Expanded(
                child: TaskText(index: index, selectedDate: selectedDate),
              ),
              //分類ラベル
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: ClassificationBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///チェックボックス用
class TaskCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Checkbox(value: true, onChanged: (bool? value) {});
  }
}

///タスク名用
class TaskText extends StatelessWidget {
  final int index;
  final DateTime selectedDate;
  const TaskText({Key? key, required this.index, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String viewDate = DateFormat('yyyy.M.d').format(selectedDate);

    return Text(
      'test：$viewDate/index：$index',
      style: TextStyle(
        color: AppColors.fontBlack,
        fontSize: 18.0,
      ),
    );
  }
}

///分類ラベル用
class ClassificationBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.baseObjectDarkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'サプリメント',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
