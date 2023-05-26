import 'package:flutter/material.dart';

class ResetPWFieldModel extends ChangeNotifier {
  String email = '';

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }
}
