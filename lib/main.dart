import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_school/firebase_options.dart';
import 'package:today_my_school/pages/home.dart';
import 'package:today_my_school/pages/login.dart';
import 'package:today_my_school/pages/password_reset.dart';
import 'package:today_my_school/pages/profile_editor.dart';
import 'package:today_my_school/pages/reservation_check.dart';
import 'package:today_my_school/pages/reservation_form.dart';
import 'package:today_my_school/pages/reservation_result.dart';
import 'package:today_my_school/pages/room_select.dart';
import 'package:today_my_school/pages/signup.dart';
import 'package:today_my_school/pages/splash.dart';
import 'package:today_my_school/style.dart';
import 'package:today_my_school/models/model_auth.dart';
import 'package:today_my_school/models/model_reservation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name:"tody-my-school",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthModel()),
        ChangeNotifierProvider(create: (_) => ReservationModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return MaterialApp(
            title: 'Today My School',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0,
                centerTitle: true,
                titleTextStyle:
                    TextStyleSet.semibold20.copyWith(color: ColorPalette.blue),
                toolbarHeight: 56.h,
              ),
              scaffoldBackgroundColor: ColorPalette.white,
              dividerTheme: DividerThemeData(
                color: ColorPalette.grey,
                space: 24.h,
                thickness: 1,
              ),
            ),
            routes: {
              '/': (context) => const SplashPage(),
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignupPage(),
              '/password_reset': (context) => const PasswordResetPage(),
              '/home': (context) => const HomePage(),
              '/profile_editor': (context) => const ProfileEditorPage(),
              '/reservation_check': (context) => const ReservationCheckPage(),
              '/room_select': (context) => const RoomSelectPage(),
              '/reservation_form': (context) => const ReservationForm(),
              '/reservation_result': (context) => const ReservationResultPage(),
            },
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
