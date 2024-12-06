import 'package:comeet/UI/profile/profile/last_tests/back_test_card.dart';
import 'package:flutter/material.dart';

import '../../../../models/test/test_model.dart';
import '../../../../request_constant/colors.dart';

class EmptyTest extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      height: size.height / 4.7,
      width: size.width * 0.8,
      padding: EdgeInsets.only(
          bottom: size.height / 50,
          right: size.width * 0.07,
          left: size.width * 0.07),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Container(
                height: size.height,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                foregroundDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: TestCardBack(profileBackBottomColor, bottomNavigationColorDark.withOpacity(0.7),
                    size.height / 5 - size.height / 50)),
            Container(

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent),
                padding: EdgeInsets.only(top: size.height / 200, right: size.height / 15, left: size.height / 200,
                bottom: size.height / 50),
                child: Center(
                  child: Text('Проходите больше\nтестов', style: theme.textTheme.titleSmall!.copyWith(
                    color: bottomNavigationColorDark
                  ),),
                )),
          ],
        ),
      ),
    );
  }
}
