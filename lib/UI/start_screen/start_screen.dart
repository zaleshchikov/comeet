import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/log_in.dart';
import 'package:comeet/UI/auth/name_data_screen.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import 'dialog.dart';
import 'message.dart';

class StartScreen extends StatefulWidget {
  bool secondWay;
  bool isClickable = true;

  StartScreen({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  initState() {
    super.initState();
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    if(widget.secondWay){
      messages = [
        ChatMessage(
            messageContent:
            "Да, в мафию. Если захочешь, конечно. Психологические тесты, сортировка коллег по интересам.. Да что я все о себе да о себе - твоя очередь. Расскажешь, кто ты?",
            messageType: "receiver"),
      ];
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          height: height * 0.92,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(height: height * 0.03),
                Container(
                  height: height / 1.5,
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: messages.length,
                    itemBuilder: (context, index, animation) {
                      return ScaleTransition(
                          scale: animation,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 10,
                                bottom: height / 100),
                            child: Row(
                              mainAxisAlignment:
                                  messages[index].messageType == "receiver"
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                messages[index].messageType == "receiver"
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            right: height / 100),
                                        child: Image(
                                            image: const AssetImage(
                                                'assets/icons/bita_icon.png'),
                                            height: height / 20),
                                      )
                                    : Container(),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: height / 100,
                                      maxWidth: width / 1.5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? theme.hoverColor
                                        : theme.primaryColor),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    messages[index].messageContent,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                        color: messages[index].messageType ==
                                                "receiver"
                                            ? theme.cardColor
                                            : theme.hoverColor),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
                Center(
                    child: InkWell(
                  onTap: () async {
                    if(userPhrases[widget.messageIndex] == 'Пойдем'){
                      Navigator.of(context)
                          .push(SlideAnimationRoute(SlideScreen()));
                    }

                    if (widget.secondWay || userPhrases[widget.messageIndex] == 'Полетели') {
                      Navigator.of(context)
                          .push(SlideAnimationRoute(BlocProvider(
                        create: (BuildContext context) => SignUpBloc(),
                        child: SignUpScreen(),
                      )));
                      return;
                    }

                    if(widget.isClickable) {
                      setState(() {
                        widget.isClickable = false;
                      });


                      if (widget.messageIndex != 3) {
                        setState(() {
                          widget.isClickable = false;
                        });

                        await Future.delayed(Duration(milliseconds: 500));
                        setState(() {
                          messages.add(userMessages[widget.messageIndex]);
                          _listKey.currentState?.insertItem(
                              messages.length - 1);
                        });
                      }
                      await Future.delayed(Duration(milliseconds: 1500));
                      setState(() {
                        messages.add(bitaMessages[widget.messageIndex]);
                        _listKey.currentState?.insertItem(messages.length - 1);
                      });
                      await Future.delayed(Duration(milliseconds: 500));
                      setState(() {
                        if (widget.secondWay) {
                          return;
                        }
                        widget.messageIndex++;
                      });

                      setState(() {
                        widget.isClickable = true;
                      });
                    }},
                  child: Container(
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              borderRadius: BorderRadius.circular(50)),
                          height: height / 15,
                          width: width * 0.9,
                          child: Center(
                            child: Text(
                              widget.secondWay
                                  ? 'Полетели!'
                                  : userPhrases[widget.messageIndex],
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                        ),
                )),
              ]),
        ),
        !widget.secondWay
            ? Row(
                children: [
                  Container(
                    width: width * 0.1,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(SlideAnimationRoute(LogInScreen()));
                      },
                      child: Container(
                          height: height / 20,
                          width: width * 0.45,
                          decoration: BoxDecoration(
                              color: purpuleColor,
                              borderRadius: BorderRadius.circular(130)),
                          child: Center(
                              child: Text(
                            'Я уже проходил регистрацию',
                            style: theme.textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          )))),
                ],
              )
            : Container()
      ],
    ));
  }
}
