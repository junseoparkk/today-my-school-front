class Reservation2{
  String? reservationToken;
  String? startTime;
  String? endTime;
  String? uuid;
  String? userEmail;
  int? roomId;
  String? roomName;
  String? purpose;
  int? memberNum;

  Reservation2({
    required this.reservationToken,
    required this.startTime,
    required this.endTime,
    required this.uuid,
    required this.userEmail,
    required this.roomId,
    required this.roomName,
    required this.purpose,
    required this.memberNum
  });

  factory Reservation2.fromMap(Map reservation2Map){
    return Reservation2(
      reservationToken: reservation2Map['reservationToken'],
      startTime: reservation2Map['startTime'],
      endTime: reservation2Map['endTime'],
      uuid: reservation2Map['uuid'],
      userEmail: reservation2Map['userEmail'],
      roomId: reservation2Map['roomId'],
      roomName: reservation2Map['roomName'],
      purpose: reservation2Map['purpose'],
      memberNum: reservation2Map['memberNum']
    );
  }
}