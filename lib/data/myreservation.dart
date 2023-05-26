class MyReservation{
  String? reservationToken;
  String? startTime;
  String? endTime;
  String? uid;
  String? email;
  int? roomId;
  String? roomName;
  String? purpose;
  int? memberNum;


  MyReservation({
      required this.reservationToken,
      required this.startTime,
      required this.endTime,
      required this.uid,
      required this.email,
      required this.roomId,
      required this.roomName,
      required this.purpose,
      required this.memberNum
  });

  factory MyReservation.fromMap(Map MyReservationMap){
  return MyReservation(
      reservationToken: MyReservationMap['reservationToken'],
      startTime: MyReservationMap['startTime'],
      endTime: MyReservationMap['endTime'],
      uid: MyReservationMap['uid'],
      email: MyReservationMap['email'],
      roomId: MyReservationMap['roomId'],
      roomName: MyReservationMap['roomName'],
      purpose: MyReservationMap['purpose'],
      memberNum: MyReservationMap['memberNum']
    );
  }
}