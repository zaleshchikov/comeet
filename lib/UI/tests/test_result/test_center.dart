import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class TestCenter extends StatelessWidget {
  Color color;
  String name;

  TestCenter({required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      height: size.height*0.8,
      width: size.width*0.9,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(40), color: color),
      child: Container(
        padding: EdgeInsets.all(size.height/50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name,
                style: theme.textTheme.titleSmall!.copyWith(color: Colors.black)),
            Container(height: size.height/50),
            Center(
              child: Container(
                height: size.height*0.4,
                width: size.width*0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: centerTestColor.withOpacity(0.35),
                    border: Border.all(color: centerTestColor.withOpacity(0.9))),
              ),
            ),
            Container(height: size.height/50)
          ],
        ),
      ),
    );
  }
}
