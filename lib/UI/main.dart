import 'package:comeet/UI/auth/meme_screen.dart';
import 'package:comeet/UI/auth/name_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'start_screen/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final fontHeight = height/852;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFBFAFE),
        primaryColor: const Color(0xff4C4FAD),
        cardColor: const Color(0xff333333),
        hoverColor: const Color(0xffEFF0F6),
        dividerColor: const Color(0xffD0D0D0),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              fontSize: fontHeight*16,
            color: Color(0xff333333)
          ),
          titleSmall: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w700,
              fontSize: fontHeight*20,
              color: Color(0xffffffff)
          ),
          titleMedium: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w700,
              fontSize: fontHeight*30,
              color: Color(0xff333333)
          ),
        ),
        useMaterial3: true,
      ),
      home: MemeScreen(),
    );
  }
}
