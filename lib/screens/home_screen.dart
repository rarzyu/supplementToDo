import 'package:flutter/material.dart';
import 'package:supplement_to_do/screens/add_edit_screen.dart';

/// 画面全体
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // リスト
      body: SafeArea(
        child: Column(
          children: [
            TopSection(),
            DateSelector(),
            Expanded(
              child: ListView.builder(
                  itemCount: 10000,
                  itemBuilder: (context, index) => ListItem(index: index)),
            ),
          ],
        ),
      ),
    );
  }
}

/// 画面最上位部分
/// 年月選択と新規追加ボタンの部分
class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Text('年月と新規追加ボタン'),
    );
  }
}

/// 日付選択部分
class DateSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      child: Text('日付部分'),
    );
  }
}

/// リストのアイテム
class ListItem extends StatelessWidget {
  final int index;
  const ListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return AddEditScreen(index: index);
          }),
        );
      },
      child: Text('ListItem:$index'),
    );
  }
}
