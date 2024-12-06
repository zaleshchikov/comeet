import 'package:flutter/material.dart';
import 'dart:math';

var rng = Random();

Color centerTestColor = const Color(0xff9CABC2);
Color colorPinkback = const Color(0xffCBB3B4);
Color colorPink = const Color(0xffF6c9c7);
Color colorPinkTitle = const Color(0xffF1A39B);
Color colorBlue = Color(0xffB1BDFA);
Color progressContainerColor = Color(0xffBDC451);
Color bottomNavigationColorDark = const Color(0xff333333);
Color profileBackBottomColor = const Color(0xffDADEE9);
Color orangeColor = const Color(0xffF0963D);
Color blueColor = const Color(0xff6662F1);
Color greenColor = const Color(0xffBDC451);
Color emptyPhotoColor = const Color(0xff9CABC2);
Color yellowColor = const Color(0xffF5C752);

List colors = [
  colorPink, blueColor, greenColor, yellowColor
];

Color getRandomColor(){
  return colors[rng.nextInt(colors.length)];
}

