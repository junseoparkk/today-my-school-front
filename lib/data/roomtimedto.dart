class RoomTimeDto{
  final int? index;
  final bool isReserved;

  RoomTimeDto({
  required this.index,
  required this.isReserved
  });

  factory RoomTimeDto.fromMap(Map roomTimeMap){
    return RoomTimeDto(
        index: roomTimeMap['index'],
        isReserved: roomTimeMap['reserved']
    );
  }

  static Map fromMapToMap(Map roomTimeMap){
    Map data = {
      "time":roomTimeMap['time'],
      "isReserved":roomTimeMap['reserved']
    };
    return data;
  }

  // static bool fromMapToBool(Map roomTimeMap){
  //   RoomTimeDto r=RoomTimeDto(
  //       index: roomTimeMap['index'],
  //       isReserved: roomTimeMap['reserved']
  //   );
  //   return r.isReserved;
  // }
}