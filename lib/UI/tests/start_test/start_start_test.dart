import 'package:comeet/UI/tests/question_screen.dart';
import 'package:comeet/UI/tests/start_test/start_questions.dart';
import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/animation_one.dart';


class StartTestStartScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: blueColor,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              minHeight: size.height / 2.3,
              minWidth: size.width * 0.9,
              maxHeight: size.height*0.7,
              maxWidth: size.width * 0.9,
            ),
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(25)),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height/100),
                      width: size.width*0.75,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Стартовый тест',
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black,
                            fontFamily: GoogleFonts.mPlusRounded1c().fontFamily,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: size.width/40),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Нам нужно понять, что вы из себя представляете",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontFamily: GoogleFonts.mPlusRounded1c().fontFamily,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(SlideAnimationRoute(
                          StartQuestionsScreen()), (route) => false);
                    },
                    child: Container(
                      padding: EdgeInsets.all(size.height/100),
                      child: Image(
                        image:
                        AssetImage('assets/tests/start_main_test_button.png'),
                        height: size.height / 5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
