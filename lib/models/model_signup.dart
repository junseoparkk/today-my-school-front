import 'package:flutter/material.dart';

class SignupFieldModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String passwordConfirm = '';
  String name = '';
  String phone = '';

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
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


  String getName(){
    return name;
  }

  String getEmail(){
    return email;
  }

  String getPassword(){
    return password;
  }

  String getPhone(){
    return phone;
  }
}
