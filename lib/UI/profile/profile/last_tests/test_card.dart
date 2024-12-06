import 'package:comeet/UI/profile/profile/last_tests/back_test_card.dart';
import 'package:flutter/material.dart';

import '../../../../models/test/test_model.dart';
import '../../../../request_constant/colors.dart';

class TestCard extends StatelessWidget {
  Test test;

  TestCard(this.test);

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
                child: TestCardBack(test.color.withOpacity(0.5), test.color,
                    size.height / 5 - size.height / 50)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent),
                padding: EdgeInsets.all(size.height / 200),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: size.width / 3.5,
                        width: size.width / 3.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage(test.photo),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: size.width / 2.3,
                        padding:
                            EdgeInsets.symmetric(vertical: size.height / 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width / 4,
                                  child: Text(test.name,
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: size.width / 4,
                                    child: Text(
                                      test.description,
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.labelMedium!
                                          .copyWith(
                                              color: bottomNavigationColorDark),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: size.width / 4,
                                    child: Text(
                                      'Результат:',
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.labelMedium!
                                          .copyWith(
                                              color: bottomNavigationColorDark),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
