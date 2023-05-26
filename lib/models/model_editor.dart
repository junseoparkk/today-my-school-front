import 'package:flutter/material.dart';

class EditorFieldModel extends ChangeNotifier {
  String email = '';
  String name = '';
  String phone = '';

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setPhone(String phone) {
    this.phone = phone;
    notifyListeners();
  }
}
