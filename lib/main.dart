import 'dart:convert';

import 'package:comeet/UI/auth/email_data_screen.dart';
import 'package:comeet/UI/auth/end_auth.dart';
import 'package:comeet/UI/auth/log_in.dart';
import 'package:comeet/UI/auth/meme_screen.dart';
import 'package:comeet/UI/auth/name_data_screen.dart';
import 'package:comeet/UI/events/event_back.dart';
import 'package:comeet/UI/events/event_screen.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/friends/friend_screen.dart';
import 'package:comeet/UI/profile/profile/last_tests/back_test_card.dart';
import 'package:comeet/UI/profile/profile/profile_screen.dart';
import 'package:comeet/UI/tests/back_test.dart';
import 'package:comeet/UI/tests/start_test/start_test_start_screen.dart';
import 'package:comeet/UI/tests/test_result/test_screen.dart';
import 'package:comeet/UI/user_card/card_screen.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'UI/tests/tests_screen.dart';
import 'request_constant/request_constant.dart';
import 'UI/auth/carousel_screen.dart';
import 'UI/start_screen/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  // if(pref.getString('accessToken') == null) {
  //   await pref.setString('accessToken',
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjN2ViMjAwMS1hMWI1LTQ0YTAtOWMwMS03NDA5YjBlYmQ2NTkiLCJpYXQiOjE3MzM2NjIzMzgsImV4cCI6MTczMzY2MjYzOH0.nMQ_WiZ7AmCu382E3VHsV4LxFheUfKuZPh2F5wAusNw');
  //   await pref.setString('refreshToken',
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjN2ViMjAwMS1hMWI1LTQ0YTAtOWMwMS03NDA5YjBlYmQ2NTkiLCJpZCI6IjhhMjBjMThkLTkxNzAtNDFjOS1hNmNhLTMyOGE4MjU1NmJkMSIsImlhdCI6MTczMzY3NDc5OCwiZXhwIjoxNzM4ODU4Nzk4fQ.AXpj7yF3E7wCv8yj9I_sdC9YbI60ruDfVP_m-o3cF6E');
  // }
    // await pref.setString('refreshToken',
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjN2ViMjAwMS1hMWI1LTQ0YTAtOWMwMS03NDA5YjBlYmQ2NTkiLCJpZCI6IjgzYjM3OTM2LTAzMDktNGM5NS1iNzQ5LTFhYzBjOTI4YjRmMCIsImlhdCI6MTczMzY4NTk1MywiZXhwIjoxNzM4ODY5OTUzfQ.KbUjN3a2QzeiXJ_ZH2Xq7IM2J7mGm7Fhr1vGwyj4U7E');
  var response = await http.post(
      Uri.parse(loginUrl),
      headers: headersUrlencoded,
      body: {
        "email": 'zaleshchikovaa@gmail.com',
        "password": '89634423139',
      });
  print(jsonDecode(response.body));
    var resBody = jsonDecode(response.body);
    await pref.setString('accessToken', resBody['accessToken']);
    await pref.setString('refreshToken', resBody['refreshToken']);


  var startWidget = pref.getString('accessToken') == null
      ? StartScreen()
      : BottomNavigationScreen(EventsScreen());
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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffFBFAFE),
          primaryColor: const Color(0xff4C4FAD),
          cardColor: const Color(0xff333333),
          hoverColor: const Color(0xffEFF0F6),
          dividerColor: const Color(0xffD0D0D0),
          canvasColor: const Color(0xff4A3AFF),
          focusColor: const Color(0xff333377),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white,
            selectionHandleColor: Colors.white,
          ),

          textTheme: TextTheme(
            labelLarge: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: fontHeight * 13,
                color: bottomNavigationColorDark),
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
        home:TestsScreen()
    );
  }
}
