import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class TestContainer extends StatelessWidget {

  Color color;
  String text;
  TestContainer({required this.color, this.text = ''});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Tooltip(
        showDuration: Duration(milliseconds: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3
          ),
          color: color.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        message: 'Подсказка',
        child: RotationTransition(
        turns: AlwaysStoppedAnimation(45 / 360),
    child: Container(
      height: size.width/4.5,
      width: size.width/4.5,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: RotationTransition(
    turns: AlwaysStoppedAnimation(-45 / 360),
    child: Text(text, style: theme.textTheme.bodyLarge!.copyWith(color: bottomNavigationColorDark),),
        )),
    )));
  }
}
