import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';

///ボトム部分
class AddEditBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    bool isEditMode = editTaskNotifierWatch.isEditMode;

    return Container(
      color: AppColors.borderGray,
      height: kBottomNavigationBarHeight * 1.5, //規定のボトムバーの高さ
      width: double.infinity,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          ///TODO
          ///完了ボタン押下時の処理
          ///このトリガーでDBに反映させる
          print('hoge');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(isEditMode ? '更新しました' : '追加しました'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: Text('OK'))
                  ],
                );
              });
        },
        child: Text(
          '完了',
          style: TextStyle(
              color: AppColors.baseObjectDarkBlue,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
