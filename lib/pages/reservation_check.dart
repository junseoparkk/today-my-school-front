import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:today_my_school/data/myreservation.dart';
import 'package:today_my_school/data/reservation.dart';
import 'package:today_my_school/services/database_services.dart';
import 'package:today_my_school/services/reservation_services.dart';
import 'package:today_my_school/style.dart';

class ReservationCheckPage extends StatefulWidget {
  const ReservationCheckPage({super.key});

  @override
  State<ReservationCheckPage> createState() => _ReservationCheckPageState();
}

class _ReservationCheckPageState extends State<ReservationCheckPage> {
  CollectionReference product = FirebaseFirestore.instance
  .collection('users')
  .doc(FirebaseAuth.instance.currentUser!.uid)
  .collection('reservations');

  ReservationServices reservationServices=ReservationServices();
  Future<List<MyReservation>>? reserveList;
  //reservationServices.getReservation(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reserveList = reservationServices.getReservation(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        foregroundColor: ColorPalette.blue,
        title: const Text('내 예약'),
      ),
      body: FutureBuilder<List<MyReservation>>(
        future: reserveList,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return SafeArea(
              bottom: false,
              child: Center(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (DateTime.parse(snapshot.data![index].startTime.toString()).isBefore(DateTime.now())) {
                      return OverdueCard(
                        place: snapshot.data![index].roomName.toString(),
                        date: DateTime.parse(snapshot.data![index].startTime.toString()),
                        startTime: DateTime.parse(snapshot.data![index].startTime.toString()),
                        endTime: DateTime.parse(snapshot.data![index].endTime.toString()),
                        numOfPeople: snapshot.data![index].memberNum ?? 0,
                        //reservationToken: snapshot.data![index].reservationToken.toString(),
                      );
                    }
                    return ReservationCard(
                      place: snapshot.data![index].roomName.toString(),
                      date: DateTime.parse(snapshot.data![index].startTime.toString()),
                      startTime: DateTime.parse(snapshot.data![index].startTime.toString()),
                      endTime: DateTime.parse(snapshot.data![index].endTime.toString()),
                      numOfPeople: snapshot.data![index].memberNum ?? 0,
                      reservationToken: snapshot.data![index].reservationToken.toString(),
                    );
                  },
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final String place;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int numOfPeople;
  final String reservationToken;

  const ReservationCard({
    super.key,
    required this.place,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.numOfPeople,
    required this.reservationToken
  });

  @override
  Widget build(BuildContext context) {
    ReservationServices reservationServices=ReservationServices();

    return Container(
      height: 168.h,
      decoration: BoxDecoration(
        color: ColorPalette.blue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 42.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.place_outlined,
                      size: 24,
                      color: ColorPalette.white,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      place,
                      style: TextStyleSet.bold16
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                   Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: (){
                        reservationServices.deleteReservation(
                            FirebaseAuth.instance.currentUser!.uid,
                            reservationToken);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            const SnackBar(content: Text('삭제 완료!')),
                          );
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 24,
                        color: ColorPalette.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 264.w,
              height: 108.h,
              decoration: BoxDecoration(
                color: ColorPalette.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 112.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '예약 날짜',
                          style: TextStyleSet.thin13,
                        ),
                        Text(
                          '이용 시간',
                          style: TextStyleSet.thin13,
                        ),
                        Text(
                          '예약 인원',
                          style: TextStyleSet.thin13,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 144.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(date),
                          style: TextStyleSet.semibold13,
                        ),
                        Text(
                          '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                          style: TextStyleSet.semibold13,
                        ),
                        Text(
                          '$numOfPeople명',
                          style: TextStyleSet.semibold13,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverdueCard extends StatelessWidget {
  final String place;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int numOfPeople;

  const OverdueCard({
    super.key,
    required this.place,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.numOfPeople,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168.h,
      decoration: BoxDecoration(
        color: ColorPalette.grey,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 42.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.place_outlined,
                      size: 24,
                      color: ColorPalette.white,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      place,
                      style: TextStyleSet.bold16
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 24,
                        color: ColorPalette.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 264.w,
              height: 108.h,
              decoration: BoxDecoration(
                color: ColorPalette.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 112.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '예약 날짜',
                          style: TextStyleSet.thin13,
                        ),
                        Text(
                          '이용 시간',
                          style: TextStyleSet.thin13,
                        ),
                        Text(
                          '예약 인원',
                          style: TextStyleSet.thin13,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 144.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(date),
                          style: TextStyleSet.semibold13
                              .copyWith(color: ColorPalette.grey),
                        ),
                        Text(
                          '${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}',
                          style: TextStyleSet.semibold13
                              .copyWith(color: ColorPalette.grey),
                        ),
                        Text(
                          '$numOfPeople명',
                          style: TextStyleSet.semibold13
                              .copyWith(color: ColorPalette.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
