import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/date_manager.dart';

///日付の状態管理
final dateManagerProvider = ChangeNotifierProvider<DateManagerNotifier>(
    create: (context) => DateManagerNotifier());

class DateManagerNotifier with ChangeNotifier {
  DateManager _dateManager;

  //初期化の際に、今日の日付を格納するが、now()を使用してしまうと時刻まで入ってしまい比較が不可能になるので年月日のみにして格納
  DateManagerNotifier()
      : _dateManager = DateManager(
          selectedDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
        );

  DateTime get selectedDate => _dateManager.selectedDate;

  void setSelectedDate(DateTime date) {
    _dateManager.selectedDate = date;
    notifyListeners();
  }
}
