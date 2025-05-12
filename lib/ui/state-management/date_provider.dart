import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  String _selectedCategory = "Follow up";

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  String get selectedCategory => _selectedCategory;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

}
