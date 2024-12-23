import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/navigation/botoom_navigation.dart';
import 'package:comeet/UI/tests/test_result/test_screen.dart';
import 'package:comeet/UI/tests/tests_screen.dart';
import 'package:comeet/bloc/test/test/test_bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatelessWidget {
  int currentQuestionIndex;

  QuestionScreen({this.currentQuestionIndex = 0});

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
        builder: (context, state) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(size.height/50),
              constraints: BoxConstraints(
                minHeight: size.height / 2.3,
                minWidth: size.width * 0.9,
                maxHeight: size.height*0.8,
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
                        state.test!.questions[currentQuestionIndex].text,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.black, fontFamily: GoogleFonts.mPlusRounded1c().fontFamily, fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                    Container(
                        width: size.width*0.8,
                        child: Divider(color: Colors.black, height: size.height/100,)),
                    Container(height: size.height/50),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: size.height / 6,
                        minWidth: size.width * 0.7,
                        maxHeight: size.height*0.8,
                        maxWidth: size.width * 0.7,
                      ),
                      child:
                      IntrinsicHeight(
                        child: Column(
                          children:
                            List<Widget>.generate(state.test!.questions[currentQuestionIndex].answerOption.length, (index) => Expanded(
                              child: Container(
                                padding: EdgeInsets.all(size.height/100),
                                child: InkWell(
                                  onTap: (){
                                    BlocProvider.of<TestBloc>(context).add(AddAnswer(currentQuestionIndex, state.test!.questions[currentQuestionIndex].answerOption[index]));
                                  },
                                  child: Container(
                                    height: size.height/15,
                                    width: size.width*0.7,
                                    decoration: BoxDecoration(
                                        color: ((state.answers!.length - 1) < currentQuestionIndex) ? Colors.white : (state.answers![currentQuestionIndex] == state.test!.questions[currentQuestionIndex].answerOption[index]) ? color : Colors.white,

                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all()
                                    ),
                                    child: Center(child: Text(state.test!.questions[currentQuestionIndex].answerOption[index].text, style: theme.textTheme.bodyMedium,)),
                                  ),
                                ),
                              ),
                            ))

                        ),
                      ),
                    ),
                Container(height: size.height/50),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){

                          if(currentQuestionIndex != 0){
                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(Icons.arrow_back_ios, color: currentQuestionIndex == 0 ? profileBackBottomColor : Colors.black, size: size.height/20),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushAndRemoveUntil(SlideAnimationRoute(BottomNavigationScreen(TestsScreen())), (d) => false);
                        },
                        child: Center(
                          child: Text('Вернуться в меню', style: theme.textTheme.bodyLarge),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          if(currentQuestionIndex == (state.test!.questions!.length-1) && (currentQuestionIndex+1) ==
                              (state.answers!.length)){
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Center(child: Text("Завершить тест?")),
                              titleTextStyle:
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,fontSize: 20),
                              actionsOverflowButtonSpacing: 20,
                              actions: [
                                Center(
                                  child: InkWell(onTap: (){
                                    Navigator.of(context).pop();
                                  }, child: Container(
                                      height: size.height/15,
                                      width: size.width*0.6,
                                      decoration: BoxDecoration(
                                          color: purpuleColor.withOpacity(0.1),
                                          border: Border.all(
                                              color: purpuleColor,
                                              width: 5
                                          ),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Center(child: Text("Сверить ответы")))),
                                ),
                                Center(
                                  child: InkWell(onTap: (){
                                      BlocProvider.of<TestBloc>(context).add(SendTestResult());
                                      Navigator.of(context).push(SlideAnimationRoute(TestResultScreen(
                                          state.test!.testResultOptions
                                          state.testResults.keys.elementAt(0))))
                                  }, child: Container(
                                      height: size.height/15,
                                      width: size.width*0.6,
                                      decoration: BoxDecoration(
                                          color: purpuleColor.withOpacity(0.1),
                                          border: Border.all(
                                              color: purpuleColor,
                                              width: 5
                                          ),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Center(child: Text("Завершить тест")))),
                                ),
                              ],
                            ));
                          } else {
                            if (currentQuestionIndex !=
                                (state.answers!.length)) {
                              Navigator.of(context).push(SlideAnimationRoute(
                                  BlocProvider.value(
                                    value: BlocProvider.of<TestBloc>(context),
                                    child: QuestionScreen(
                                      currentQuestionIndex: currentQuestionIndex +
                                          1,),)));
                            }
                          }},
                        child: Icon(Icons.arrow_forward_ios, color: currentQuestionIndex == (state.answers!.length) ? profileBackBottomColor : Colors.black, size: size.height/20),
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
