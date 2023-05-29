import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:today_my_school/data/reservation.dart';
import 'package:today_my_school/style.dart';

class ReservationResultPage extends StatefulWidget {
  const ReservationResultPage({
    super.key,
    this.date,
    this.place,
    this.startTime,
    this.endTime,
    });

  final DateTime? date;
  final String? place;
  final String? startTime;
  final String? endTime;
  
  @override
  State<ReservationResultPage> createState() => _ReservationResultPageState();
}

class _ReservationResultPageState extends State<ReservationResultPage> {
  // final String _place = reservations[0].place;
  // final DateTime _date = reservations[0].date;
  // final DateTime _startTime = reservations[0].startTime;
  // final DateTime _endTime = reservations[0].endTime;
  String _name = '';
  String _phone = '';

  Future _getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(() {
            _name = snapshot.data()!['name'];
            _phone = snapshot.data()!['phone'];
            snapshot.data()!['uid'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.blue,
        foregroundColor: ColorPalette.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 154.h,
                      decoration: const BoxDecoration(
                        color: ColorPalette.blue,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.zero,
                          bottom: Radius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16.h,
                      child: Column(
                        children: [
                          Text(
                            '예약이 완료되었어요!',
                            style: TextStyleSet.medium20
                                .copyWith(color: ColorPalette.white),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            width: 295.w,
                            height: 376.h,
                            decoration: BoxDecoration(
                              color: ColorPalette.white.withOpacity(0.9),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '예약 정보',
                                  style: TextStyleSet.semibold20
                                      .copyWith(color: ColorPalette.blue),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 72.w,
                                          margin: EdgeInsets.only(left: 40.w),
                                          child: Text(
                                            '장소',
                                            style: TextStyleSet.bold16.copyWith(
                                              color: ColorPalette.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.place!,
                                          //_place,
                                          style: TextStyleSet.medium15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.h),
                                    Row(
                                      children: [
                                        Container(
                                          width: 72.w,
                                          margin: EdgeInsets.only(left: 40.w),
                                          child: Text(
                                            '일정',
                                            style: TextStyleSet.bold16.copyWith(
                                              color: ColorPalette.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat('yyyy년 M월 d일 EEEE', 'ko_KR').format(widget.date!)}\n${DateFormat('HH:mm').format(DateTime.parse(widget.startTime!))} - ${DateFormat('HH:mm').format(DateTime.parse(widget.endTime!))}',
                                          style: TextStyleSet.medium15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.h),
                                    Row(
                                      children: [
                                        Container(
                                          width: 72.w,
                                          margin: EdgeInsets.only(left: 40.w),
                                          child: Text(
                                            '예약자',
                                            style: TextStyleSet.bold16.copyWith(
                                              color: ColorPalette.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _name,
                                          style: TextStyleSet.medium15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.h),
                                    Row(
                                      children: [
                                        Container(
                                          width: 72.w,
                                          margin: EdgeInsets.only(left: 40.w),
                                          child: Text(
                                            '연락처',
                                            style: TextStyleSet.bold16.copyWith(
                                              color: ColorPalette.grey,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _phone.isEmpty
                                              ? ''
                                              : '${_phone.substring(0, 3)}-${_phone.substring(3, 7)}-${_phone.substring(7)}',
                                          style: TextStyleSet.medium15,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const GoHomeButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class GoHomeButton extends StatelessWidget {
  const GoHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.w,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/home');
        },
        child: Text(
          '홈으로',
          style: TextStyleSet.bold16.copyWith(color: ColorPalette.white),
        ),
      ),
    );
  }
}
