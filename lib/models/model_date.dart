import 'package:flutter/cupertino.dart';

class DateModel extends ChangeNotifier{
  DateTime date=DateTime.now();

  void setDate(DateTime date){
    this.date = date;
    notifyListeners();
  }
}