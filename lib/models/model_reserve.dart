import 'package:flutter/material.dart';

class ReserveFieldModel extends ChangeNotifier {
  String place = '';
  DateTime date = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
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

  void setStartTime(DateTime startTime) {
    this.startTime = startTime;
    notifyListeners();
  }

  void setEndTime(DateTime endTime) {
    this.endTime = endTime;
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
