import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/tests/test_result/test_screen.dart';
import 'package:comeet/UI/tests/tests_screen.dart';
import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  int currentQuestionIndex;

  QuestionScreen({this.currentQuestionIndex = 0});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool _isButtonTapped = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    Color color = getRandomColor();
    return BlocBuilder<TestBloc, TestState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: color,
          body: BlocBuilder<TestBloc, TestState>(
            builder: (context1, state) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(size.height / 50),
                  constraints: BoxConstraints(
                    minHeight: size.height / 2.3,
                    minWidth: size.width * 0.9,
                    maxHeight: size.height * 0.8,
                    maxWidth: size.width * 0.9,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            state.test!.questions[widget.currentQuestionIndex].text,
                            style: theme.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                                fontFamily:
                                    GoogleFonts.mPlusRounded1c().fontFamily,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                            width: size.width * 0.8,
                            child: Divider(
                              color: Colors.black,
                              height: size.height / 100,
                            )),
                        Container(height: size.height / 50),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: size.height / 6,
                            minWidth: size.width * 0.7,
                            maxHeight: size.height * 0.8,
                            maxWidth: size.width * 0.7,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                                children: List<Widget>.generate(
                                    state.test!.questions[widget.currentQuestionIndex]
                                        .answerOption.length,
                                    (index) => Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                size.height / 100),
                                            child: GestureDetector(
                                              onTap: () {
                                                BlocProvider.of<TestBloc>(
                                                        context1)
                                                    .add(AddAnswer(
                                                        widget.currentQuestionIndex,
                                                        state
                                                            .test!
                                                            .questions[
                                                                widget.currentQuestionIndex]
                                                            .answerOption[index]));
                                              },
                                              child: Container(
                                                height: size.height / 15,
                                                width: size.width * 0.7,
                                                decoration: BoxDecoration(
                                                    color: ((state.answers!
                                                                    .length -
                                                                1) <
                                                            widget.currentQuestionIndex)
                                                        ? Colors.white
                                                        : (state.answers![
                                                                    widget.currentQuestionIndex] ==
                                                                state
                                                                        .test!
                                                                        .questions[
                                                                            widget.currentQuestionIndex]
                                                                        .answerOption[
                                                                    index])
                                                            ? color
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all()),
                                                child: Center(
                                                    child: Text(
                                                  state
                                                      .test!
                                                      .questions[
                                                          widget.currentQuestionIndex]
                                                      .answerOption[index]
                                                      .text,
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ))),
                          ),
                        ),
                        Container(height: size.height / 50),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.currentQuestionIndex != 0) {
                                    Navigator.of(context1).pop();
                                  }
                                },
                                child: Icon(Icons.arrow_back_ios,
                                    color: widget.currentQuestionIndex == 0
                                        ? profileBackBottomColor
                                        : Colors.black,
                                    size: size.height / 20),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context1).pushAndRemoveUntil(
                                      SlideAnimationRoute(
                                          BottomNavigationScreen(
                                              TestsScreen())),
                                      (d) => false);
                                },
                                child: Center(
                                  child: Text('Вернуться в меню',
                                      style: theme.textTheme.bodyLarge),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.currentQuestionIndex ==
                                          (state.test!.questions!.length - 1) &&
                                      (widget.currentQuestionIndex + 1) ==
                                          (state.answers!.length)) {
                                    showDialog(
                                        context: context1,
                                        builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<TestBloc>(
                                                context),
                                            child: BlocListener<TestBloc,
                                                TestState>(
                                              listener: (context, state) {
                                                if (state.endTest) {}
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        SlideAnimationRoute(
                                                            TestResultScreen(
                                                                state
                                                                    .testResults!
                                                                    .keys
                                                                    .elementAt(
                                                                        0))),
                                                        (_) => false);
                                              },
                                              child: BlocBuilder<TestBloc,
                                                  TestState>(
                                                builder: (context, state) {
                                                  return AlertDialog(
                                                    title: Center(
                                                        child: Text(
                                                            "Завершить тест?")),
                                                    titleTextStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                    actionsOverflowButtonSpacing:
                                                        20,
                                                    actions: [
                                                      Center(
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context1)
                                                                  .pop();
                                                            },
                                                            child: Container(
                                                                height: size.height /
                                                                    15,
                                                                width:
                                                                    size.width *
                                                                        0.6,
                                                                decoration: BoxDecoration(
                                                                    color: purpuleColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    border: Border.all(
                                                                        color:
                                                                            purpuleColor,
                                                                        width:
                                                                            5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Center(
                                                                    child: Text(
                                                                        "Сверить ответы")))),
                                                      ),
                                                      Center(
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                  if (!_isButtonTapped) {
                                                    setState(() {
                                                      _isButtonTapped == true;
                                                    });
                                                    BlocProvider.of<
                                                        TestBloc>(
                                                        context1)
                                                        .add(
                                                        UpdateTestResult());
                                                    BlocProvider.of<TestBloc>(
                                                        context).add(
                                                        SendTestResult());
                                                  }},
                                                            child: Container(
                                                                height: size.height /
                                                                    15,
                                                                width:
                                                                    size.width *
                                                                        0.6,
                                                                decoration: BoxDecoration(
                                                                    color: purpuleColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    border: Border.all(
                                                                        color:
                                                                            purpuleColor,
                                                                        width:
                                                                            5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Center(
                                                                    child: Text(
                                                                        "Завершить тест")))),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            )));
                                  } else {
                                    if (widget.currentQuestionIndex !=
                                        (state.answers!.length)) {
                                      Navigator.of(context1).push(
                                          SlideAnimationRoute(
                                              BlocProvider.value(
                                        value:
                                            BlocProvider.of<TestBloc>(context1),
                                        child: QuestionScreen(
                                          currentQuestionIndex:
                                              widget.currentQuestionIndex + 1,
                                        ),
                                      )));
                                    }
                                  }
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    color: widget.currentQuestionIndex ==
                                            (state.answers!.length)
                                        ? profileBackBottomColor
                                        : Colors.black,
                                    size: size.height / 20),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
