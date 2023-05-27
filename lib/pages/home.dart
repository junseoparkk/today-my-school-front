import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_school/style.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri _urlField = Uri.parse(
      'https://www.kmou.ac.kr/kmou/rf/rentfclts/rentFcltsView.do?mi=2025');
  final Uri _urlLibrary =
      Uri.parse('https://library.kmou.ac.kr/studyroom/groupReserveStat/4');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.blue,
        foregroundColor: ColorPalette.white,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/reservation_check');
          },
          child: Text(
            '내 예약',
            style: TextStyleSet.medium15.copyWith(color: ColorPalette.white),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/profile_editor');
            },
            icon: const Icon(
              Icons.settings_rounded,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const UserProfileDisplay(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const NavigationButton(
                      image: 'assets/images/meeting_room.png',
                      textHead: '학내 스터디존 예약하기',
                      textCaption: '* 어울림관 아치라운지\n* 해양과학기술관 2층',
                      route: '/room_select',
                    ),
                    NavigationButton(
                      image: 'assets/images/library.png',
                      textHead: '도서관 시설물 예약하기',
                      textCaption: '* 예약 사이트로 연결됩니다',
                      uri: _urlLibrary,
                    ),
                    NavigationButton(
                      image: 'assets/images/football_field.png',
                      textHead: '인조잔디구장 예약하기 ',
                      textCaption: '* 예약 사이트로 연결됩니다',
                      uri: _urlField,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileDisplay extends StatefulWidget {
  const UserProfileDisplay({super.key});

  @override
  State<UserProfileDisplay> createState() => _UserProfileDisplayState();
}

class _UserProfileDisplayState extends State<UserProfileDisplay> {
  String email = '';
  String name = '';
  String phone = '';

  Future _getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (mounted) {
          setState(() {
            email = snapshot.data()!['email'];
            name = snapshot.data()!['name'];
            phone = snapshot.data()!['phone'];
            snapshot.data()!['uid'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 154.h,
      decoration: const BoxDecoration(
        color: ColorPalette.blue,
        borderRadius: BorderRadius.vertical(
          top: Radius.zero,
          bottom: Radius.circular(50),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: TextStyleSet.semibold18.copyWith(color: ColorPalette.white),
          ),
          SizedBox(height: 16.h),
          Text(
            email,
            style: TextStyleSet.regular13.copyWith(color: ColorPalette.white),
          ),
          SizedBox(height: 4.h),
          Text(
            phone.isEmpty
                ? ''
                : '${phone.substring(0, 3)}-${phone.substring(3, 7)}-${phone.substring(7)}',
            style: TextStyleSet.regular13.copyWith(color: ColorPalette.white),
          ),
          SizedBox(height: 64.h),
        ],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String image;
  final String textHead;
  final String textCaption;
  final String? route;
  final Uri? uri;

  const NavigationButton({
    super.key,
    required this.image,
    required this.textHead,
    required this.textCaption,
    this.route,
    this.uri,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      height: 120.h,
      child: ElevatedButton(
        onPressed: () {
          if (route != null && uri == null) {
            Navigator.of(context).pushNamed(route!);
          } else if (uri != null && route == null) {
            launchUrl(uri!);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                  width: 80.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textHead,
                      style: TextStyleSet.medium18,
                      softWrap: true,
                    ),
                    Text(
                      textCaption,
                      style: TextStyleSet.light13,
                      softWrap: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
