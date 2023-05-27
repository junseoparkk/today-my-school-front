import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:today_my_school/services/reservation_services.dart';

enum ReservationStatus {
  success,
  fail,
}

class ReservationModel with ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;
  final ReservationServices reservationServices=ReservationServices();

  Future<ReservationStatus> reserveRoom(
    String place,
    DateTime? date,
    String startTime,
    String endTime,
    int numOfPeople,
    String purpose
  ) async {
    CollectionReference reservations =
        FirebaseFirestore.instance.collection('reservations');
    String uid = _user!.uid;
    try {
      await reservations.doc().set({
        'place': place,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'numOfPeople': numOfPeople,
        'purpose': purpose,
        'uid': uid,
      });
      // String sTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime);
      // String eTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);
      // int roomId = idx;
      // reservationServices.addReservation(roomId, uid, sTime, eTime, purpose, numOfPeople);

      return ReservationStatus.success;
    } catch (e) {
      print(e);
      return ReservationStatus.fail;
    }
  }
}
