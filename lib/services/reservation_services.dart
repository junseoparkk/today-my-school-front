import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:today_my_school/data/reservation.dart';
import 'package:today_my_school/data/reservation2.dart';
import 'package:today_my_school/data/roomtimedto.dart';

import '../data/myreservation.dart';
import '../data/user.dart';
import 'globals.dart';

class ReservationServices {
  Future<Reservation2> addReservation(int roomId, String uuid, String startTime,
      String endTime, String purpose, int memberNum) async {
    Map data = {
      "uuid": uuid,
      "startTime": startTime,
      "endTime": endTime,
      "purpose": purpose,
      "memberNum": memberNum
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/room/${roomId}/reservation');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    //return Reservation2.fromMap(data);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Reservation2.fromMap(data);
    } else if(response.statusCode == 500){
      throw HttpException("예약 실패!");
    }
    else{
      return Reservation2.fromMap(data);
    }
    // Map responeMap = jsonDecode(response.body);
    // User user = User.fromMap(responeMap);
    // return user;
  }

  Future<List<MyReservation>> getReservation(String uuid) async {
    var url = Uri.parse(baseURL + '/reservation/${uuid}');

    http.Response response = await http.get(
      url,
      //headers: headers,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );
    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    List<MyReservation> allReserv = body.map((dynamic reserv) =>
        MyReservation.fromMap(reserv)).toList();

    // for(MyReservation t in allReserv)
    //   print({t.roomName,t.startTime!.substring(11)});

    return allReserv;
  }

  Future<MyReservation> deleteReservation(String uuid,String reservationToken) async{
    var url = Uri.parse(baseURL + '/reservation/${reservationToken}');

    Map data = {
      "uuid":uuid
    };

    var body = json.encode(data);

    http.Response response = await http.delete(
      url,
      headers: headers,
      body: body,
    );
    return MyReservation.fromMap(data);
  }

  Future<List<RoomTimeDto>> getRoomTime(int roomId, String date) async{
    var url = Uri.parse(baseURL + '/room/${roomId}/date/${date}');

    http.Response response = await http.get(
        url,
        //headers: headers,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        }
    );

    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    List<RoomTimeDto> roomTimeDto = body.map((dynamic data) =>
        RoomTimeDto.fromMap(data)).toList();

    for(RoomTimeDto t in roomTimeDto)
      print({t.index,t.possible});

    return roomTimeDto;
  }
}