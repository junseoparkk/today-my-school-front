import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReserveFieldModel extends ChangeNotifier {
  String place = '';
  DateTime date = DateTime.now();
  String startTime = '';
  String endTime = '';
  int numOfPeople = 0;
  String purpose = '';
  int roomId=0;

  void setRoomId(int roomId){
    this.roomId = roomId;
    notifyListeners();
  }

  void setPlace(String place) {
    this.place = place;
    notifyListeners();
  }

  void setDate(DateTime date) {
    this.date = date;
    notifyListeners();
  }

  void setStartTime(String startTime) {
    String head = DateFormat('yyyy-MM-dd').format(date);
    String tail = startTime.split('-')[0];
    this.startTime = '$head $tail:00';
    notifyListeners();
  }

  void setEndTime(String endTime) {
    String head = DateFormat('yyyy-MM-dd').format(date);
    String tail = endTime.split('-')[1];
    this.endTime = '$head $tail:00';
    notifyListeners();
  }

  void setNumOfPeople(int numOfPeople) {
    this.numOfPeople = numOfPeople;
    notifyListeners();
  }

  void setPurpose(String purpose) {
    this.purpose = purpose;
    notifyListeners();
  }
}
