import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/tests/back_test.dart';
import 'package:comeet/UI/tests/test_result/test_center.dart';
import 'package:comeet/UI/tests/tests_screen.dart';
import 'package:comeet/models/tests/TestResultOption.dart';
import 'package:comeet/models/tests/answer_options.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class TestResultScreen extends StatefulWidget {

  TestResultOption testResult;

  TestResultScreen(this.testResult);
  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height, width: size.width,
              child: TestBack(colorPinkback)),

          Center(child: TestCenter(color: Color(0xffF6C9C7), name: widget.testResult.text)),

          Container(
            padding: EdgeInsets.only(top: size.height*0.87),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(SlideAnimationRoute(TestsScreen()));
          },
                  child: Container(
                    height: size.height/15,
                    width: size.width*0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.transparent
                    ),
                    child: Center(
                      child: Text(
                        'все тесты', style: theme.textTheme.titleSmall!.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: size.height/15,
                //   width: size.width*0.4,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black),
                //       borderRadius: BorderRadius.circular(50),
                //       color: theme.cardColor
                //   ),
                //   child: Center(
                //     child: Text(
                //       'дальше', style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
