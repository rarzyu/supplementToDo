/// 日付の状態管理

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/date_manager.dart';

final dateManagerProvider = ChangeNotifierProvider<DateManagerNotifier>(
    create: (context) => DateManagerNotifier());

class DateManagerNotifier with ChangeNotifier {
  DateManager _dateManager;

  DateManagerNotifier()
      : _dateManager = DateManager(
          selectedDate: DateTime.now(),
          displayedYearMonth: DateTime.now(),
        );

  DateTime get selectedDate => _dateManager.selectedDate;
  DateTime get displayedYearMonth => _dateManager.displayedYearMonth;

  void setSelectedDate(DateTime date) {
    _dateManager.selectedDate = date;
    notifyListeners();
  }

  void setDisplayedYearMonth(DateTime date) {
    _dateManager.displayedYearMonth = DateTime(date.year, date.month);
    notifyListeners();
  }
}
