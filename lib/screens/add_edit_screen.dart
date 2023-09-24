import 'package:flutter/material.dart';

class AddEditScreen extends StatelessWidget {
  final int index;
  const AddEditScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('追加・編集画面')),
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('追加・編集画面の内容 $index'),
      )),
    );
  }
}
