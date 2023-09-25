/// タスク一覧

import 'package:flutter/material.dart';
import 'package:supplement_to_do/screens/add_edit/add_edit_screen.dart';

/// セクション全体
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 10000,
          itemBuilder: (context, index) => ListItem(index: index)),
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
