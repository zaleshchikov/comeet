import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/carousel_screen.dart';
import 'package:comeet/UI/start_screen/message.dart';
import 'package:comeet/UI/start_screen/message_widget.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../start_screen/dialog.dart';

class MemeScreen extends StatefulWidget {
  var emailLabelText = 'Почта';
  var passwordLabelText = 'Телефон';

  bool secondWay;

  MemeScreen({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<MemeScreen> createState() => _EmailDataSCreen();
}

class _EmailDataSCreen extends State<MemeScreen> {
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

    return Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    progressCircle(true, 1),
                    progressContainer(1),
                    progressCircle(true, 2),
                    progressContainer(0),
                    progressCircle(false, 3),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width/20),
                      padding: EdgeInsets.all(size.height/100),
                      width: size.width/2,
                      height: size.width/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: theme.hoverColor
                      ),
                      child: Center(child: Image.asset('assets/meme/meme.png')),
                    ),
                  ],
                ),
          Center(
              child: InkWell(
                onTap: () async {
                  debugPrint(BlocProvider.of<SignUpBloc>(context).state.email);
                  debugPrint(BlocProvider.of<SignUpBloc>(context).state.password);
                  Navigator.of(context).push(SlideAnimationRoute(BlocProvider.value(
                      value: BlocProvider.of<SignUpBloc>(context),
                      child:CarouselScreen())));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
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
                              color: theme
                                  .textTheme.titleSmall!.color,
                            )))
                        : Text(
                      ':)',
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
              ))
              ]));

  }
}
