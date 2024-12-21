import 'package:comeet/UI/events/event_back.dart';
import 'package:comeet/UI/profile/profile/last_tests/test_card.dart';
import 'package:comeet/UI/tests/back_test.dart';
import 'package:comeet/UI/tests/test_card.dart';
import 'package:comeet/bloc/test/test_preview/test_preview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../request_constant/colors.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});
  static final form = FormGroup({
    'text': FormControl<String>(validators: [Validators.required]),
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return BlocProvider(
  create: (context) => TestPreviewBloc()..add(getTestPreviews()),
  child: Builder(
    builder: (context) {
      return Scaffold(
            resizeToAvoidBottomInset: false,
            body: ReactiveForm(
              formGroup: form,
              child: Stack(
                children: [
                  TestBack(profileBackBottomColor),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: size.height/15),
                      Center(
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height / 15,
                          child: ReactiveTextField(
                            style: theme.textTheme.bodyMedium,
                            cursorColor: theme.textTheme.bodySmall!.color,
                            decoration: InputDecoration(
                                suffixIcon:
                                Icon(Icons.search, size: size.height / 20),
                                filled: true,
                                fillColor: Colors.white,
                                label: Row(
                                  children: [
                                    Container(width: 20),
                                    Text('найти тесты'),
                                  ],
                                ),
                                labelStyle: theme.textTheme.bodyMedium,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black),
                                    borderRadius: BorderRadius.circular(40)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black),
                                    borderRadius: BorderRadius.circular(40)),
                                focusColor: Colors.black),
                            formControlName: 'text',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.1),
                        child: Row(
                          children: [
                            Text(
                              'Тесты:',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(color: bottomNavigationColorDark),
                            ),
                          ],
                        ),
                      ),
                      TestCards()

                    ],
                  )
                ],
              ),
            ),
          );
    }
  ),
);
  }
}
