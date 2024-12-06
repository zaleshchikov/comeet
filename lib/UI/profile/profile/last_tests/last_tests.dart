import 'package:comeet/UI/profile/profile/last_tests/empty_test.dart';
import 'package:comeet/UI/profile/profile/last_tests/test_card.dart';
import 'package:comeet/models/test/test_model.dart';
import 'package:flutter/material.dart';

import '../../../../request_constant/colors.dart';

class LastTests extends StatelessWidget {
  const LastTests({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var tests = [
      Test('Тест_1', 'Описание теста', 'assets/test_images/test1.jpeg',
          colorPink),
    ];
    ;
    return Container(
        height: size.height / 2,
        width: size.width,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 2,
          itemBuilder: (context, index) => index <= tests.length-1 ? TestCard(tests[index]) : EmptyTest(),
        ));
  }
}
