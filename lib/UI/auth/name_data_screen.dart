import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/email_data_screen.dart';
import 'package:comeet/UI/start_screen/message.dart';
import 'package:comeet/UI/start_screen/message_widget.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../start_screen/dialog.dart';

class SignUpScreen extends StatefulWidget {
  var nameLabelText = 'Имя';
  var professionLabelText = 'Профессия';

  bool secondWay;

  SignUpScreen({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  progressCircle(true, 1),
                  progressContainer(0.5),
                  progressCircle(false, 2),
                  progressContainer(0),
                  progressCircle(false, 3),
                ],
              ),
              message(
                  ChatMessage(
                      messageContent: 'Так как вас зовут?',
                      messageType: 'receiver'),
                  height,
                  width,
                  theme),
              ReactiveForm(
                formGroup: SignUpForm.form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: size.width / 1.2,
                      child: ReactiveTextField(
                        onChanged: (_) => BlocProvider.of<SignUpBloc>(context)
                          .add(SignUpDataEvent(
                              name: SignUpForm.name,
                            profession: SignUpForm.profession)),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                          'Что-то тут явно не так',
                          ValidationMessage.email: (error) =>
                          'Что-то тут явно не так',
                        },
                        style: theme.textTheme.bodySmall,
                        cursorColor: theme.textTheme.bodySmall!.color,
                        decoration: InputDecoration(

                          label: Row(
                            children: [
                              Container(width: 20),
                              Text(widget.nameLabelText),
                            ],
                          ),
                          labelStyle: theme.textTheme.bodySmall!.copyWith(),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        formControlName: 'name',
                      ),
                    ),
                    Container(
                      height: size.height / 12,
                    ),
                    SizedBox(
                      width: size.width / 1.2,
                      child: ReactiveTextField(
                        onChanged: (_) => BlocProvider.of<SignUpBloc>(context)
                          ..add(SignUpDataEvent(
                              name: SignUpForm.name,
                              profession: SignUpForm.profession)),
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              'Что-то тут явно не так',
                          ValidationMessage.email: (error) =>
                              'Что-то тут явно не так',
                        },
                        style: theme.textTheme.bodySmall,
                        cursorColor: theme.textTheme.bodySmall!.color,
                        decoration: InputDecoration(
                          label: Row(
                            children: [
                              Container(width: 20),
                              Text(widget.professionLabelText),
                            ],
                          ),
                          labelStyle: theme.textTheme.bodySmall,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        formControlName: 'profession',
                      ),
                    ),

                    Container(height: height / 7),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        return ReactiveFormConsumer(
                            builder: (context, form, child) {
                          return Center(
                              child: GestureDetector(
                            onTap: () async {
                               if(form.valid){
                                 BlocProvider.of<SignUpBloc>(context).add(SendSignUpDataEvent());
                                 Navigator.of(context).push(SlideAnimationRoute(
                                     BlocProvider.value(
                                         value: BlocProvider.of<SignUpBloc>(context),
                                         child:
                                         Builder(
                                           builder: (context) {
                                             return EmailDataScreen();
                                           }
                                         ))
                                 ));
                               } else{
                                 form.control('name').markAllAsTouched();
                                 form.control('profession').markAllAsTouched();
                               }
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
                                        'Вот так',
                                        style: theme.textTheme.titleSmall,
                                      ),
                              ),
                            ),
                          ));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ]));
      }),
    );
  }
}
