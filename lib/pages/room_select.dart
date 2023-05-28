import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:today_my_school/data/room.dart';
import 'package:today_my_school/data/roomtimedto.dart';
import 'package:today_my_school/pages/reservation_form.dart';
import 'package:today_my_school/services/room_services.dart';
import 'package:today_my_school/style.dart';

import '../services/reservation_services.dart';

class RoomSelectPage extends StatefulWidget {
  const RoomSelectPage({super.key});

  @override
  State<RoomSelectPage> createState() => _RoomSelectPageState();
}


class _RoomSelectPageState extends State<RoomSelectPage> {
  String _selectedDate =
      DateFormat('yyyy-MM-dd (E)', 'ko_KR').format(DateTime.now());

  Future<List<Room>>? rooms;
  RoomServices roomServices = RoomServices();

  ReservationServices reservationServices=ReservationServices();
  Future<List<Map>>? timeList1;
  Future<List<Map>>? timeList2;
  Future<List<Map>>? timeList3;
  Future<List<Map>>? timeList4;
  Future<List<Map>>? timeList5;
  Future<List<Map>>? timeList6;
  Future<List<Map>>? timeList7;
  Future<List<Map>>? timeList8;
  Future<List<Map>>? timeList9;

  Future _selectDate() async{
    final DateTime? selected = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024,12,31),
      selectableDayPredicate: (date){
        if(date.isAfter(DateTime(
          DateTime.now().add(const Duration(days: 6)).year,
          DateTime.now().add(const Duration(days: 6)).month,
          DateTime.now().add(const Duration(days: 6)).day,
        ))) {
          return false;
        } else {
          return true;
        }
      },
    );
    if (selected != null){
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd (E)','ko_KR').format(selected);
      });
    }
  }


  // Future setAllList() async{
  //   rooms[0].setAvailable((await timeList1)!);
  //   rooms[1].setAvailable((await timeList2)!);
  //   rooms[2].setAvailable((await timeList3)!);
  //   rooms[3].setAvailable((await timeList4)!);
  //   rooms[4].setAvailable((await timeList5)!);
  //   rooms[5].setAvailable((await timeList6)!);
  //   rooms[6].setAvailable((await timeList7)!);
  //   rooms[7].setAvailable((await timeList8)!);
  //   rooms[8].setAvailable((await timeList9)!);
  //
  //   print("setAllList!!!");
  //   print("========");
  //   print(rooms[0].isAvailable[0]);
  //   print("========");
  //   print(timeList1);
  // }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    timeList1 = reservationServices.getRoomTime(1,_selectedDate);
    timeList2 = reservationServices.getRoomTime(2,_selectedDate);
    timeList3 = reservationServices.getRoomTime(3,_selectedDate);
    timeList4 = reservationServices.getRoomTime(4,_selectedDate);
    timeList5 = reservationServices.getRoomTime(5,_selectedDate);
    timeList6 = reservationServices.getRoomTime(6,_selectedDate);
    timeList7 = reservationServices.getRoomTime(7,_selectedDate);
    timeList8 = reservationServices.getRoomTime(8,_selectedDate);
    timeList9 = reservationServices.getRoomTime(9,_selectedDate);

    rooms = roomServices.setRooms(
      timeList1,
      timeList2,
      timeList3,
      timeList4,
      timeList5,
      timeList6,
      timeList7,
      timeList8,
      timeList9
    );

    //setAllList();
    }

    @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    timeList1 = reservationServices.getRoomTime(1,_selectedDate);
    timeList2 = reservationServices.getRoomTime(2,_selectedDate);
    timeList3 = reservationServices.getRoomTime(3,_selectedDate);
    timeList4 = reservationServices.getRoomTime(4,_selectedDate);
    timeList5 = reservationServices.getRoomTime(5,_selectedDate);
    timeList6 = reservationServices.getRoomTime(6,_selectedDate);
    timeList7 = reservationServices.getRoomTime(7,_selectedDate);
    timeList8 = reservationServices.getRoomTime(8,_selectedDate);
    timeList9 = reservationServices.getRoomTime(9,_selectedDate);

    rooms = roomServices.setRooms(
        timeList1,
        timeList2,
        timeList3,
        timeList4,
        timeList5,
        timeList6,
        timeList7,
        timeList8,
        timeList9
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.blue,
        foregroundColor: ColorPalette.white,
        title: const Text(
          '예약하기',
          style: TextStyle(color: ColorPalette.white),
        ),
      ),
      body: FutureBuilder<List<Room>>(
        future: rooms,
        builder: (context, snapshot) {
          List<Room>rooms = snapshot.requireData;
          return SafeArea(
            bottom: false,
            child: Center(
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
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate();
                          },
                          child: Container(
                            width: 280.w,
                            height: 32.h,
                            margin: EdgeInsets.fromLTRB(0, 8.h, 0, 16.h),
                            decoration: BoxDecoration(
                              color: ColorPalette.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  size: 24,
                                ),
                                Text(
                                  ' $_selectedDate',
                                  style: TextStyleSet.medium15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16.h,
                              );
                            },
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return ReservationStatusCard(
                                place: rooms[index].place,
                                location: rooms[index].location,
                                maxCapacity: rooms[index].maxCapacity,
                                image: rooms[index].image,
                                isAvailable: rooms[index].isAvailable,
                                index: index,
                                room: rooms[index]
                              );
                            },
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
      ),
    );
  }
}

class ReservationStatusCard extends StatefulWidget {
  final String place;
  final String location;
  final int maxCapacity;
  final String image;
  List isAvailable;
  final int index;
  Room room;

  ReservationStatusCard({
    super.key,
    required this.place,
    required this.location,
    required this.maxCapacity,
    required this.image,
    required this.isAvailable,
    required this.index,
    required this.room
  });

  @override
  State<ReservationStatusCard> createState() => _ReservationStatusCardState();
}

class _ReservationStatusCardState extends State<ReservationStatusCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            //builder: (context) => ReservationForm(room: rooms[widget.index])));
            builder: (context) => ReservationForm(room: widget.room)));
        //Navigator.of(context).pushNamed('/reservation_form',arguments: ReservationForm(room: rooms[widget.index]));
      },
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: ColorPalette.white,
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
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 72.w,
                      height: 72.h,
                      child: Image.asset(
                        widget.image,
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
                      widget.place,
                      style: TextStyleSet.medium15,
                    ),
                    Text(
                      widget.location,
                      style: TextStyleSet.light13,
                    ),
                    Text(
                      '최대 ${widget.maxCapacity}명 이용 가능',
                      style: TextStyleSet.light13,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 2.w);
                },
                itemCount: widget.isAvailable.length,
                itemBuilder: (context, index) {
                  if (widget.isAvailable[index]['isReserved']) {
                    return Container(
                      width: 28.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: ColorPalette.grey.withOpacity(0.7),
                      ),
                    );
                  }else{
                    return Container(
                      width: 28.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                        color: ColorPalette.green,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
