import 'package:flutter/material.dart';
import 'dart:math';

var rng = Random();

Color loginColor = const Color(0xffDADEE9);
Color centerTestColor = const Color(0xff9CABC2);
Color colorPinkback = const Color(0xffCBB3B4);
Color colorPink = const Color(0xffF6C9C7);
Color recoverAuthColor = const Color(0xffCBB3B4);
Color colorPinkTitle = const Color(0xffF1A39B);

Color colorBlue = Color(0xffB1BDFA);
Color purpuleColor = const Color(0xff4C4FAD);
Color progressContainerColor = Color(0xffBDC451);
Color bottomNavigationColorDark = const Color(0xff333333);
Color profileBackBottomColor = const Color(0xffDADEE9);
Color orangeColor = const Color(0xffF0963D);
Color blueColor = const Color(0xffB1BDFA);
Color greenColor = const Color(0xffD4DB6D);
Color emptyPhotoColor = const Color(0xff9CABC2);
Color yellowColor = const Color(0xffECA865);

List colors = [
  colorPink, blueColor, greenColor, yellowColor
];

Color getRandomColor(){
  return colors[rng.nextInt(colors.length)];
}

