class Room {
  final int roomId;
  final String place;
  final String location;
  final String availablTime;
  final int maxTime;
  final int maxCapacity;
  final List? facilities;
  final String image;

  Room({
    required this.roomId,
    required this.place,
    required this.location,
    required this.availablTime,
    required this.maxTime,
    required this.maxCapacity,
    this.facilities,
    required this.image,
  });
}

List<Room> rooms = [
  Room(
    roomId: 1,
    place: '아치라운지 대회의실',
    location: '어울림관 4층',
    availablTime: '09:00 - 18:00',
    maxTime: 2,
    maxCapacity: 10,
    facilities: ['LED TV', 'PC', '화이트보드'],
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 2,
    place: '아치라운지 소회의실 A',
    location: '어울림관 4층',
    availablTime: '09:00 - 18:00',
    maxTime: 2,
    maxCapacity: 4,
    facilities: ['LED TV', 'PC', '화이트보드'],
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 3,
    place: '아치라운지 소회의실 B',
    location: '어울림관 4층',
    availablTime: '09:00 - 18:00',
    maxTime: 2,
    maxCapacity: 4,
    facilities: ['LED TV', 'PC', '화이트보드'],
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 4,
    place: '아치라운지 소회의실 C',
    location: '어울림관 4층',
    availablTime: '09:00 - 18:00',
    maxTime: 2,
    maxCapacity: 4,
    facilities: ['LED TV', 'PC', '화이트보드'],
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 5,
    place: '해과기관 스터디존 A',
    location: '해양과학기술관 2층',
    availablTime: '00:00 - 24:00',
    maxTime: 2,
    maxCapacity: 4,
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 6,
    place: '해과기관 스터디존 B',
    location: '해양과학기술관 2층',
    availablTime: '00:00 - 24:00',
    maxTime: 2,
    maxCapacity: 4,
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 7,
    place: '해과기관 스터디존 C',
    location: '해양과학기술관 2층',
    availablTime: '00:00 - 24:00',
    maxTime: 8,
    maxCapacity: 4,
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 8,
    place: '해과기관 스터디존 D',
    location: '해양과학기술관 2층',
    availablTime: '00:00 - 24:00',
    maxTime: 2,
    maxCapacity: 4,
    image: 'assets/images/sample.jpg',
  ),
  Room(
    roomId: 9,
    place: '해과기관 스터디존 E',
    location: '해양과학기술관 2층',
    availablTime: '00:00 - 24:00',
    maxTime: 2,
    maxCapacity: 4,
    image: 'assets/images/sample.jpg',
  ),
];
