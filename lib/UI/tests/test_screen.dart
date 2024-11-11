import 'package:comeet/UI/tests/back_test.dart';
import 'package:comeet/UI/tests/test_center.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
              child: TestBack(color_pink)),
          Container(
                  padding: EdgeInsets.only(top: size.height/20, left: size.width/20),
                  child: IconButton(
                                icon: ImageIcon(AssetImage('assets/icons/back_icon.png'),
                    size: size.height / 20),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                ),
          Center(child: TestCenter(color: Color(0xffF6C9C7), name: 'Тест\n“Какой ты тип личности”')),

          Container(
            padding: EdgeInsets.only(top: size.height*0.87),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
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
                Container(
                  height: size.height/15,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(50),
                      color: theme.cardColor
                  ),
                  child: Center(
                    child: Text(
                      'дальше', style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
