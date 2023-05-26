
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_my_school/models/model_editor.dart';
import 'package:today_my_school/models/model_signup.dart';
import 'package:today_my_school/services/database_services.dart';

enum AuthStatus {
  signupSuccess,
  signupFail,
  loginSuccess,
  loginFail,
  resetSuccess,
  resetFail,
  addSuccess,
  addFail,
  updateSuccess,
  updateFail,
}

class AuthModel with ChangeNotifier {
  final FirebaseAuth _auth;
  final DatabaseServices databaseServices=DatabaseServices();
  User? _user;

  AuthModel({auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<AuthStatus> signupWithEmail(SignupFieldModel signupField) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: signupField.email, password: signupField.password);
      AuthStatus addUserStatus =
          await addUser(credential.user!.uid, signupField);
      if (addUserStatus == AuthStatus.addFail) {
        return AuthStatus.signupFail;
      }

      databaseServices.signUpUser(
        signupField.getName(),
        signupField.getEmail(),
        signupField.getPassword(),
        signupField.getPhone(),
        credential.user!.uid
      );

      return AuthStatus.signupSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.signupFail;
    }
  }

  Future<AuthStatus> addUser(String uid, SignupFieldModel signupField) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(uid).set({
        'email': signupField.email,
        'name': signupField.name,
        'phone': signupField.phone,
        'uid': uid,
      });
      return AuthStatus.addSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.addFail;
    }
  }

  Future<AuthStatus> loginWithEmail(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credential) async {
        _user = credential.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('email', email);
        prefs.setString('password', password);
      });
      print("[+] 로그인유저 : ${_user!.email}");
      return AuthStatus.loginSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.loginFail;
    }
  }

  Future<AuthStatus> updateUser(EditorFieldModel editorField) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String uid = _user!.uid;
    try {
      await users.doc(uid).set({
        'email': editorField.email,
        'name': editorField.name,
        'phone': editorField.phone,
        'uid': uid,
      });
      databaseServices.updateUser(uid,editorField.name, editorField.email, editorField.phone);
      return AuthStatus.updateSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.updateFail;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
    prefs.setString('password', '');
    _user = null;
    await _auth.signOut();
    print("[-] 로그아웃");
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthStatus.resetSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.resetFail;
    }
  }
}
