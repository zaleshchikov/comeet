import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/meme_screen.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/profile/profile/profile_screen.dart';
import 'package:comeet/UI/start_screen/message.dart';
import 'package:comeet/UI/start_screen/message_widget.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/UI/tests/start_test/start_start_test.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../start_screen/dialog.dart';

class EndAuth extends StatefulWidget {
  var emailLabelText = 'Почта';
  var passwordLabelText = 'Пароль';

  bool secondWay;

  EndAuth({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<EndAuth> createState() => _EmailDataSCreen();
}

class _EmailDataSCreen extends State<EndAuth> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget progressCircle(bool selected, int index) => Container(
          height: height / 25,
          width: height / 25,
          decoration: BoxDecoration(
              color: selected ? theme.primaryColor : theme.dividerColor,
              shape: BoxShape.circle),
          child: Center(
            child: Text(index.toString(),
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: selected ? Colors.white : theme.cardColor)),
          ),
        );

    Widget progressContainer(double progress) => Container(
          width: width / 4,
          height: height / 130,
          decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: [
              Container(
                height: height / 50,
                width: width / 4 * progress,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ],
          ),
        );

    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.isSuccessRequest) {
            Navigator.of(context).push(
                SlideAnimationRoute(StartTestStartScreen()));
          }
        },
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                progressCircle(true, 1),
                progressContainer(1),
                progressCircle(true, 2),
                progressContainer(1),
                progressCircle(true, 3),
              ],
            ),
            message(
                ChatMessage(
                    messageContent:
                        'Все готово! Спасибо за проявленное доверие и полетели знакомиться с коллегами, Битя',
                    messageType: 'receiver'),
                height,
                width,
                theme),
            Container(height: height / 7),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Center(
                    child: InkWell(
                  onTap: () async {
                    BlocProvider.of<SignUpBloc>(context)
                        .add(SendSignUpDataEvent());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(50)),
                    height: height / 15,
                    width: width * 0.9,
                    child: Center(
                      child: BlocProvider.of<SignUpBloc>(context)
                              .state
                              .isLoading
                          ? Center(
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    color: theme.textTheme.titleSmall!.color,
                                  )))
                          : Text(
                              'Вот так',
                              style: theme.textTheme.titleSmall,
                            ),
                    ),
                  ),
                ));
              },
            ),
          ],
        )));
  }
}
