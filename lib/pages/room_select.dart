import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:today_my_school/data/room.dart';
import 'package:today_my_school/pages/reservation_form.dart';
import 'package:today_my_school/style.dart';

class RoomSelectPage extends StatefulWidget {
  const RoomSelectPage({super.key});

  @override
  State<RoomSelectPage> createState() => _RoomSelectPageState();
}

class _RoomSelectPageState extends State<RoomSelectPage> {
  String _selectedDate =
      DateFormat('yyyy-MM-dd (E)', 'ko_KR').format(DateTime.now());

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
      body: SafeArea(
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
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return ReservationStatusCard(
                            place: rooms[index].place,
                            location: rooms[index].location,
                            maxCapacity: rooms[index].maxCapacity,
                            image: rooms[index].image,
                            isAvailable: rooms[index].isAvailable,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationStatusCard extends StatefulWidget {
  final String place;
  final String location;
  final int maxCapacity;
  final String image;
  List<bool> isAvailable;
  final int index;

  ReservationStatusCard({
    super.key,
    required this.place,
    required this.location,
    required this.maxCapacity,
    required this.image,
    required this.isAvailable,
    required this.index,
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
            builder: (context) => ReservationForm(room: rooms[widget.index])));
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
                  if (widget.isAvailable[index]) {
                    return Container(
                      width: 28.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                        color: ColorPalette.green,
                      ),
                    );
                  }
                  return Container(
                    width: 28.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                      color: ColorPalette.lightGrey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
