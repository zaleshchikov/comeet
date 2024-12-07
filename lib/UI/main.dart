import 'package:comeet/UI/auth/email_data_screen.dart';
import 'package:comeet/UI/auth/end_auth.dart';
import 'package:comeet/UI/auth/meme_screen.dart';
import 'package:comeet/UI/auth/name_data_screen.dart';
import 'package:comeet/UI/events/event_back.dart';
import 'package:comeet/UI/events/event_screen.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/friends/friend_screen.dart';
import 'package:comeet/UI/profile/profile/last_tests/back_test_card.dart';
import 'package:comeet/UI/profile/profile/profile_screen.dart';
import 'package:comeet/UI/tests/back_test.dart';
import 'package:comeet/UI/tests/test_screen.dart';
import 'package:comeet/UI/user_card/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/carousel_screen.dart';
import 'start_screen/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getString('accessToken') == null) {
    await pref.setString('accessToken',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjN2ViMjAwMS1hMWI1LTQ0YTAtOWMwMS03NDA5YjBlYmQ2NTkiLCJpYXQiOjE3MzM1OTA2NjQsImV4cCI6MTczMzU5MDk2NH0.ec2ztHmFYHVdIu2K4Tf53M7AL90a-OwAshS4ugTsbpI');
    await pref.setString('refreshToken',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjN2ViMjAwMS1hMWI1LTQ0YTAtOWMwMS03NDA5YjBlYmQ2NTkiLCJpZCI6IjJhNThmNGYwLTYzNDYtNDA2MC1hMGIzLWY5YTNmNmVhYmM4MyIsImlhdCI6MTczMzU5MDY2NCwiZXhwIjoxNzM4Nzc0NjY0fQ.-nEUerfJATHLLOw1oLfKk9bE4zyivooyEFfayBHCqSM');
  }
  var startWidget = pref.getString('accessToken') == null
      ? StartScreen()
      : BottomNavigationScreen(ProfileScreen());
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final fontHeight = height / 852;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffFBFAFE),
          primaryColor: const Color(0xff4C4FAD),
          cardColor: const Color(0xff333333),
          hoverColor: const Color(0xffEFF0F6),
          dividerColor: const Color(0xffD0D0D0),
          canvasColor: const Color(0xff4A3AFF),
          focusColor: const Color(0xff333377),
          textTheme: TextTheme(
            labelMedium: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: fontHeight * 13,
                color: Color(0xffDADEE9)),
            bodyMedium: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: fontHeight * 16,
                color: Color(0xff333333)),
            bodyLarge: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: fontHeight * 18,
                color: Color(0xff333377)),
            titleSmall: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: fontHeight * 20,
                color: Color(0xffffffff)),
            titleLarge: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: fontHeight * 25,
                color: Color(0xff333333)),
            titleMedium: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w700,
                fontSize: fontHeight * 30,
                color: Color(0xff333333)),
          ),
          useMaterial3: true,
        ),
        home: startWidget);
  }
}
