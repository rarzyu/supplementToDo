import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supplement_to_do/config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';

///追加・編集画面の最上位セクション
class AddEditTopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //状態管理
    final editTaskNotifierWatch = context.watch<EditTaskNotifier>();
    bool isEditMode = editTaskNotifierWatch.isEditMode;

    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          Text(
            isEditMode ? "タスクの編集" : "タスクの追加",
          ),
          isEditMode
              ? TextButton(
                  onPressed: () {
                    ///TODO
                    ///削除ボタンの処理
                    ///このトリガーでDBから削除する
                    print('delete');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('削除しました'),
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
                    '削除',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
