import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import 'add_edit_section_title.dart';

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

///モーダル表示用ボタン
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
        onPressed: () => RepeatSelectModal().showCustomModal(context),
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

///モーダル
class RepeatSelectModal {
  void showCustomModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RepeatModalTab(),
                Divider(
                  color: AppColors.borderGray,
                ),

                ///共通部分
                Container(
                  height: 40,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('キャンセル')),
                    TextButton(
                        onPressed: () {
                          //ここに格納処理
                          Navigator.pop(context);
                        },
                        child: Text('完了'))
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///タブ部分
class RepeatModalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(
              dividerColor: AppColors.borderGray,
              labelColor: AppColors.baseObjectDarkBlue,
              //選択されていないタブのテキスト色
              unselectedLabelColor: AppColors.fontBlackBold,
              // インジケーターの色
              indicatorColor: AppColors.baseObjectDarkBlue,
              tabs: [
                Tab(text: '毎日'),
                Tab(text: '曜日ごと'),
                Tab(text: '日数ごと'),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: TabBarView(
                children: [
                  IntrinsicHeight(child: Text('毎日の内容')),
                  IntrinsicHeight(child: Text('毎週◯曜日の内容')),
                  IntrinsicHeight(child: Text('◯日ごとの内容')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
