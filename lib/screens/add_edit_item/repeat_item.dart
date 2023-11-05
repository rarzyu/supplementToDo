import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants/color.dart';
import '../../providers/edit_task_notifier.dart';
import 'add_edit_section_title.dart';

///繰り返し選択
class Repeat extends StatelessWidget {
  final Icon icon = Icon(Icons.repeat, color: AppColors.fontBlackBorder);
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

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeBackGray, shadowColor: Colors.black),
      onPressed: () => RepeatSelectModal().showCustomModal(context),
      child: Text(
        editTaskNotifierWatch.repeatTitle == ''
            ? '繰り返しを設定'
            : editTaskNotifierWatch.repeatTitle,
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.fontBlackBorder),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.40,
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
              unselectedLabelColor: AppColors.fontBlack,
              // インジケーターの色
              indicatorColor: AppColors.baseObjectDarkBlue,
              tabs: [
                Tab(text: '毎日'),
                Tab(text: '毎週◯曜日'),
                Tab(text: '◯日ごと'),
              ],
            ),
            Container(
              // コンテンツの高さを制限するためのコンテナ
              height: 200.0, // この高さは必要に応じて調整します
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
