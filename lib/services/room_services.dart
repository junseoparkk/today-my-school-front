import '../data/room.dart';

class RoomServices{
  Future<List<Room>> setRooms(
      Future<List<Map>>? time1,
      Future<List<Map>>? time2,
      Future<List<Map>>? time3,
      Future<List<Map>>? time4,
      Future<List<Map>>? time5,
      Future<List<Map>>? time6,
      Future<List<Map>>? time7,
      Future<List<Map>>? time8,
      Future<List<Map>>? time9,
      ) async{

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
        isAvailable: (await time1)!
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
        isAvailable: (await time2)!
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
        isAvailable: (await time3)!
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
        isAvailable: (await time4)!
      ),
      Room(
        roomId: 5,
        place: '해과기관 스터디존 A',
        location: '해양과학기술관 2층',
        availablTime: '00:00 - 24:00',
        maxTime: 2,
        maxCapacity: 4,
        image: 'assets/images/sample.jpg',
        isAvailable: (await time5)!
      ),
      Room(
        roomId: 6,
        place: '해과기관 스터디존 B',
        location: '해양과학기술관 2층',
        availablTime: '00:00 - 24:00',
        maxTime: 2,
        maxCapacity: 4,
        image: 'assets/images/sample.jpg',
        isAvailable: (await time6)!
      ),
      Room(
        roomId: 7,
        place: '해과기관 스터디존 C',
        location: '해양과학기술관 2층',
        availablTime: '00:00 - 24:00',
        maxTime: 8,
        maxCapacity: 4,
        image: 'assets/images/sample.jpg',
        isAvailable: (await time7)!
      ),
      Room(
        roomId: 8,
        place: '해과기관 스터디존 D',
        location: '해양과학기술관 2층',
        availablTime: '00:00 - 24:00',
        maxTime: 2,
        maxCapacity: 4,
        image: 'assets/images/sample.jpg',
        isAvailable: (await time8)!
      ),
      Room(
        roomId: 9,
        place: '해과기관 스터디존 E',
        location: '해양과학기술관 2층',
        availablTime: '00:00 - 24:00',
        maxTime: 2,
        maxCapacity: 4,
        image: 'assets/images/sample.jpg',
        isAvailable: (await time9)!
      ),
    ];
    return rooms;
  }
}