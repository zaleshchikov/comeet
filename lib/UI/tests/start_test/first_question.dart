import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/tests/test_result/test_screen.dart';
import 'package:comeet/UI/tests/tests_screen.dart';
import 'package:comeet/bloc/start_test/start_test_bloc.dart';
import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstStartQuestion extends StatefulWidget {


  String title;
  List<String> answersOptions;

  FirstStartQuestion(this.title, this.answersOptions);

  @override
  State<FirstStartQuestion> createState() => _FirstStartQuestionState();
}

class _FirstStartQuestionState extends State<FirstStartQuestion> {


  List<String> answers = [];
  final Color color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocBuilder<StartTestBloc, StartTestState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: color,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(size.height / 60),
                constraints: BoxConstraints(
                  minHeight: size.height / 2.3,
                  minWidth: size.width * 0.9,
                  maxHeight: size.height * 0.95,
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
                          widget.title,
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
                      Container(
                          constraints: BoxConstraints(
                              maxHeight: size.height * 0.95,
                              minHeight: size.height * 0.6,
                              maxWidth: size.width * 0.8,
                              minWidth: size.width * 0.8),
                          child: IntrinsicHeight(
                            child: Column(
                              children: List<Widget>.generate(
                                  widget.answersOptions.length,
                                  (index) => Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: size.height/100),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            answers.contains(
                                                widget.answersOptions[index])
                                                ? answers.remove(
                                                widget.answersOptions[index])
                                                : answers
                                                    .add(widget.answersOptions[index]);
                                          });
                                        },
                                        child: Container(
                                          height: size.height/20,
                                          width: size.width*0.7,
                                          decoration: BoxDecoration(
                                              color: answers.contains(
                                                  widget.answersOptions[index])
                                                  ? color.withOpacity(0.5)
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                              border: Border.all()),
                                          child: Center(
                                            child: Text(widget.answersOptions[index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          )),
                      InkWell(
                        onTap: () {



                          BlocProvider.of<StartTestBloc>(context)
                              .add(SetTags(answers));
                          answers = [];
                        },
                        child: Container(
                          height: size.height / 15,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 3)),
                          child: Center(
                            child: state.isLoading
                                ? CircularProgressIndicator(color: bottomNavigationColorDark)
                                : Text('Отправить ответы'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
