class RoomTimeDto{
  final int? index;
  final bool? possible;

  RoomTimeDto({
  required this.index,
  required this.possible
  });

  factory RoomTimeDto.fromMap(Map roomTimeMap){
    return RoomTimeDto(
        index: roomTimeMap['index'],
        possible: roomTimeMap['possible']
    );
  }
}