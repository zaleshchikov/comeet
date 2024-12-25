import 'package:carousel_slider/carousel_slider.dart';
import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/end_auth.dart';
import 'package:comeet/UI/start_screen/message.dart';
import 'package:comeet/UI/start_screen/message_widget.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../start_screen/dialog.dart';

class CarouselScreen extends StatefulWidget {
  var emailLabelText = 'Почта';
  var passwordLabelText = 'Телефон';


  bool secondWay;

  CarouselScreen({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<CarouselScreen> createState() => _CarouselScreen();
}

class _CarouselScreen extends State<CarouselScreen> {
  var carouselController = CarouselSliderController();

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

    return BlocBuilder<SignUpBloc, SignUpState>(
  builder: (context, state) {
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
                progressContainer(0.5),
                progressCircle(false, 3),
              ],
            ),
            Container(
              height: height/1.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width/20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Возраст:', style: theme.textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Row(
                          children: [
                            Text('${state.yearsOld}', style: theme.textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w300),)
                          ],
                        ),
                        Center(
                          child: Image.asset('assets/meme/r.png', height: height/50,),
                        ),
                        CarouselSlider.builder(
                            carouselController: carouselController,
                            options: CarouselOptions(
                                onPageChanged: (index, _) {
                                  BlocProvider.of<SignUpBloc>(context).add(ChangeYearsOld(index));

                                },
                              height: height / 20,
                              aspectRatio: 1 / 50,
                              viewportFraction: 0.025,
                              initialPage: state.yearsOld,
                            ),
                            itemCount: 100,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.zero,
                                      width: width / 200,
                                      height:
                                          itemIndex % 5 == 0 ? height / 30 : height / 50,
                                      decoration: BoxDecoration(
                                          color: ((itemIndex - 2 <= state.yearsOld) &&
                                                  (itemIndex + 2 >= state.yearsOld))
                                              ? state.yearsOld == itemIndex ? theme.canvasColor : theme.focusColor
                                              : theme.canvasColor.withOpacity(0.3)),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width/20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Опыт работы в годах:', style: theme.textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Row(
                          children: [
                            Text('${state.yearsOfWorking}', style: theme.textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w300),)
                          ],
                        ),
                        Center(
                          child: Image.asset('assets/meme/r.png', height: height/50,),
                        ),
                        CarouselSlider.builder(
                            carouselController: carouselController,
                            options: CarouselOptions(
                              onPageChanged: (index, _) {
                                BlocProvider.of<SignUpBloc>(context).add(ChangeYearsOfWorkingOld(index));
                              },
                              height: height / 20,
                              aspectRatio: 1 / 50,
                              viewportFraction: 0.025,
                              initialPage: state.yearsOfWorking,
                            ),
                            itemCount: 100,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.zero,
                                      width: width / 200,
                                      height:
                                      itemIndex % 5 == 0 ? height / 30 : height / 50,
                                      decoration: BoxDecoration(
                                          color: ((itemIndex - 2 <= state.yearsOfWorking) &&
                                              (itemIndex + 2 >= state.yearsOfWorking))
                                              ? state.yearsOfWorking == itemIndex ? theme.canvasColor : theme.focusColor
                                              : theme.canvasColor.withOpacity(0.3)),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width/20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Рост в см:', style: theme.textTheme.bodySmall!.copyWith(color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Row(
                          children: [
                            Text('${state.humanHeight}', style: theme.textTheme.titleSmall!.copyWith(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w300),)
                          ],
                        ),
                        Center(
                          child: Image.asset('assets/meme/r.png', height: height/50,),
                        ),
                        CarouselSlider.builder(
                            carouselController: carouselController,
                            options: CarouselOptions(
                              onPageChanged: (index, _) {
                                BlocProvider.of<SignUpBloc>(context).add(ChangeHeight(index));
                              },
                              height: height / 20,
                              aspectRatio: 1 / 50,
                              viewportFraction: 0.025,
                              initialPage: state.humanHeight,
                            ),
                            itemCount: 300,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.zero,
                                      width: width / 200,
                                      height:
                                      itemIndex % 5 == 0 ? height / 30 : height / 50,
                                      decoration: BoxDecoration(
                                          color: ((itemIndex - 2 <= state.humanHeight) &&
                                              (itemIndex + 2 >= state.humanHeight))
                                              ? state.humanHeight == itemIndex ? theme.canvasColor : theme.focusColor
                                              : theme.canvasColor.withOpacity(0.3)),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Center(
                child: InkWell(
              onTap: () async {
                Navigator.of(context).push(SlideAnimationRoute(BlocProvider.value(
                    value: BlocProvider.of<SignUpBloc>(context),
                    child:EndAuth())));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                height: height / 15,
                width: width * 0.9,
                child: Center(
                  child: BlocProvider.of<SignUpBloc>(context).state.isLoading
                      ? Center(
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: theme.textTheme.titleSmall!.color,
                              )))
                      : Text(
                          'Долго еще?',
                          style: theme.textTheme.titleSmall,
                        ),
                ),
              ),
            ))
          ]));
  },
);

  }
}
