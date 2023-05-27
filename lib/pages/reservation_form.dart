import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:today_my_school/models/model_reservation.dart';
import 'package:today_my_school/models/model_reserve.dart';
import 'package:today_my_school/data/room.dart';
import 'package:today_my_school/services/reservation_services.dart';
import 'package:today_my_school/style.dart';

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key, this.room});

  final Room? room;

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  static final _formKey = GlobalKey<FormState>();

  static String name = '';
  static String phone = '';

  Future _getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) {
        if (snapshot.exists) {
          if(mounted){
            setState(() {
              name = snapshot.data()!['name'];
              phone = snapshot.data()!['phone'];
              snapshot.data()!['uid'];
            });
          }
        }
      },
    );
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUser();
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReserveFieldModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.white,
          foregroundColor: ColorPalette.blue,
          title: const Text('예약 정보 입력'),
        ),

        body: FutureBuilder(
          future: _getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
            // reserveField.place = widget.room!.place;
            // reserveField.roomId = widget.room!.roomId;
            //if(phone.isNotEmpty)
            if(snapshot.hasData){
              return SafeArea(
                bottom: false,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: RoomInfo(
                                  place: widget.room!.place,
                                  location: widget.room!.location,
                                  maxTime: widget.room!.maxTime,
                                  maxCapacity: widget.room!.maxCapacity,
                                  image: widget.room!.image),
                            ),
                            Container(
                              height: 16.h,
                              color: ColorPalette.blue.withOpacity(0.05),
                            ),
                            const DatePicker(),
                            Container(
                              height: 16.h,
                              color: ColorPalette.blue.withOpacity(0.05),
                            ),
                            TimePicker(room: widget.room),
                            Container(
                              height: 16.h,
                              color: ColorPalette.blue.withOpacity(0.05),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 16.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const InputGuide(),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            8.w, 0, 0, 22.h),
                                        child: Text(
                                          "이름",
                                          style: TextStyleSet.light13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 192.w,
                                        height: 40.h,
                                        child: Text(
                                          name,
                                          style: TextStyleSet.regular15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //이름
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            8.w, 0, 0, 22.h),
                                        child: Text(
                                          "연락처",
                                          style: TextStyleSet.light13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 192.w,
                                        height: 40.h,
                                        child: Text(
                                          '${_ReservationFormState.phone.substring(0, 3)}-${_ReservationFormState.phone.substring(3, 7)}-${_ReservationFormState.phone.substring(7)}',
                                          style: TextStyleSet.regular15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const NameDisplay(),
                                  // const PhoneDisplay(),
                                  /*DateDisplay(),
                                TimeDisplay(),*/
                                  const NumOfPeopleInput(),
                                  const PurposeInput(),
                                ],
                              ),
                            ),
                            const ReserveButton(),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }else{
             return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class RoomInfo extends StatelessWidget {
  final String place;
  final String location;
  final int maxTime;
  final int maxCapacity;
  final String image;

  const RoomInfo({
    super.key,
    required this.place,
    required this.location,
    required this.maxTime,
    required this.maxCapacity,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 16.w, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80.w,
              height: 80.h,
              child: Image.asset(
                image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              place,
              style: TextStyleSet.semibold18,
            ),
            Text(
              location,
              style: TextStyleSet.light15,
            ),
            Text(
              '최대 $maxTime시간 이용 가능',
              style: TextStyleSet.light13,
            ),
            Text(
              '최대 $maxCapacity명 이용 가능',
              style: TextStyleSet.light13,
            ),
          ],
        ),
      ],
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    return ExpansionTile(
      title: const Text('날짜'),
      children: [
        TableCalendar(
          locale: 'ko_KR',
          focusedDay: focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2024, 12, 31),
          enabledDayPredicate: (day) {
            if (day.isBefore(DateTime(
              DateTime.now().add(const Duration(days: 7)).year,
              DateTime.now().add(const Duration(days: 7)).month,
              DateTime.now().add(const Duration(days: 7)).day,
            ))) {
              return true;
            } else {
              return false;
            }
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              this.focusedDay = selectedDay;
            });
            reserveField.setDate(selectedDay);
          },
          selectedDayPredicate: (day) =>
              day.year == selectedDay.year &&
              day.month == selectedDay.month &&
              day.day == selectedDay.day,
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
              todayTextStyle: const TextStyle(color: ColorPalette.black),
              todayDecoration: BoxDecoration(
                color: ColorPalette.blue.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: ColorPalette.white),
              selectedDecoration: const BoxDecoration(
                color: ColorPalette.blue,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: const TextStyle(color: ColorPalette.grey),
              disabledTextStyle: const TextStyle(color: ColorPalette.grey),
              defaultTextStyle: const TextStyle(color: ColorPalette.black)),
        )
      ],
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({super.key,this.room});

  final Room? room;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  static List selectedTime = [];

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReservationModel>(context, listen: false);

    return ExpansionTile(
      title: const Text('시간'),
      tilePadding: EdgeInsets.symmetric(horizontal: 24.h),
      childrenPadding: EdgeInsets.only(bottom: 16.h),
      iconColor: ColorPalette.black,
      collapsedIconColor: ColorPalette.black,
      textColor: ColorPalette.black,
      collapsedTextColor: ColorPalette.black,
      children: [
        SizedBox(
          height: 36.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.room!.isAvailable.length,
            itemBuilder: (context, index) {
              if (widget.room!.isAvailable[index]['isReserved']) {
                return Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: ColorPalette.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.room!.isAvailable[index]['time'],
                      style: TextStyleSet.regular13
                          .copyWith(color: ColorPalette.white),
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () {
                  if (selectedTime
                      .contains(widget.room!.isAvailable[index]['time'])) {
                    selectedTime
                        .remove(widget.room!.isAvailable[index]['time']);
                    //print(selectedTime);
                  } else if (selectedTime.length < 2) {
                    selectedTime.add(widget.room!.isAvailable[index]['time']);
                    //print(selectedTime);
                  }
                },
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: selectedTime
                        .contains(widget.room!.isAvailable[index]['time'])
                        ? ColorPalette.blue
                        : ColorPalette.white,
                    border: Border.all(color: ColorPalette.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.room!.isAvailable[index]['time'],
                      style: TextStyleSet.regular13,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class InputGuide extends StatelessWidget {
  const InputGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '* ',
        style: TextStyleSet.semibold15.copyWith(color: ColorPalette.red),
        children: <TextSpan>[
          TextSpan(text: '예약자 정보', style: TextStyleSet.medium18),
        ],
      ),
    );
  }
}

class NameDisplay extends StatelessWidget {
  const NameDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 0, 22.h),
          child: Text(
            '이름',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: _ReservationFormState.name,
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              filled: true,
              fillColor: ColorPalette.lightGrey.withOpacity(0.2),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}

class PhoneDisplay extends StatelessWidget {
  const PhoneDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 0, 22.h),
          child: Text(
            '연락처',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: _ReservationFormState.phone.isEmpty
                ? ''
                : '${_ReservationFormState.phone.substring(0, 3)}-${_ReservationFormState.phone.substring(3, 7)}-${_ReservationFormState.phone.substring(7)}',
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              filled: true,
              fillColor: ColorPalette.grey.withOpacity(0.15),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}

/*
class DateDisplay extends StatelessWidget {
  const DateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            '이용 날짜',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: '이용 날짜',
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.blue,
                  width: 2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 2,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text(
            '이용 시간',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: '이용 시간',
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.blue,
                  width: 2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 2,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}
*/

class NumOfPeopleInput extends StatelessWidget {
  const NumOfPeopleInput({super.key});

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 0, 22.h),
          child: Text(
            '이용 인원',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (numOfPeople) {
              reserveField.setNumOfPeople(int.parse(numOfPeople));
            },
            validator: (numOfPeople) {
              if (numOfPeople!.trim().isEmpty) {
                return '이용 인원을 입력하세요';
              }
              if (int.parse(numOfPeople) > 4) {
                return '최대 이용 인원을 초과했습니다';
              }
              return null;
            },
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.blue,
                  width: 2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 2,
                ),
              ),
            ),
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}

class PurposeInput extends StatelessWidget {
  const PurposeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 0, 22.h),
          child: Text(
            '이용 목적',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            onChanged: (purpose) {
              reserveField.setPurpose(purpose);
            },
            validator: (purpose) {
              if (purpose!.trim().isEmpty) {
                return '이용 목적을 입력하세요';
              }
              return null;
            },
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.blue,
                  width: 2,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.red,
                  width: 2,
                ),
              ),
            ),
            cursorColor: ColorPalette.black,
          ),
        ),
      ],
    );
  }
}

class ReserveButton extends StatelessWidget {
  const ReserveButton({super.key,this.room});

  final Room? room;

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<ReservationModel>(context, listen: false);
    final reserveField = Provider.of<ReserveFieldModel>(context, listen: false);
    final ReservationServices reservationServices=ReservationServices();
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
        onPressed: () async {
          if(_TimePickerState.selectedTime.isEmpty){
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('시간을 선택해주세요')),
              );
          }
          else if (_ReservationFormState._formKey.currentState!.validate()) {
            reserveField.setPlace(room!.place);
            _TimePickerState.selectedTime.sort();
            reserveField.setStartTime(_TimePickerState.selectedTime.first);
            reserveField.setEndTime(_TimePickerState.selectedTime.last);

            await reservationServices.addReservation(
                reserveField.roomId,
                FirebaseAuth.instance.currentUser!.uid,
                reserveField.startTime,
                reserveField.endTime,
                reserveField.purpose,
                reserveField.numOfPeople);

            await reservation
                .reserveRoom(
              reserveField.place,
              reserveField.date,
              reserveField.startTime,
              reserveField.endTime,
              reserveField.numOfPeople,
              reserveField.purpose,
            )
                .then(
                  (reservationStatus) {
                if (reservationStatus == ReservationStatus.success) {
                  Navigator.of(context)
                      .pushReplacementNamed('/reservation_result');
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('예약에 실패했어요 다시 시도해주세요')),
                    );
                }
              },
            );
          }
        },
        child: Text(
          '예약하기',
          style: TextStyleSet.bold16.copyWith(color: ColorPalette.white),
        ),
      ),
    );
  }
}