import 'package:comeet/UI/animation/animation_one.dart';
import 'package:comeet/UI/auth/meme_screen.dart';
import 'package:comeet/UI/start_screen/message.dart';
import 'package:comeet/UI/start_screen/message_widget.dart';
import 'package:comeet/UI/start_screen/swiping_screen.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../start_screen/dialog.dart';

class EmailDataScreen extends StatefulWidget {
  var emailLabelText = 'Почта';
  var passwordLabelText = 'Телефон';

  bool secondWay;

  EmailDataScreen({this.secondWay = false});

  int messageIndex = 0;

  @override
  State<EmailDataScreen> createState() => _EmailDataSCreen();
}

class _EmailDataSCreen extends State<EmailDataScreen> {
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
                      progressContainer(1),
                      progressCircle(false, 2),
                      progressContainer(0),
                      progressCircle(false, 3),
                    ],
                  ),
                  message(
                      ChatMessage(
                          messageContent: 'Поделитесь почтой и телефоном? Я пришлю Вам мем :)',
                          messageType: 'receiver'),
                      height,
                      width,
                      theme),
                  ReactiveForm(
                    formGroup: SignUpForm.emailForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: size.width / 1.2,
                          child: ReactiveTextField(
                            onChanged: (_) => BlocProvider.of<SignUpBloc>(context)
                              ..add(SignUpDataEvent(
                                  name: SignUpForm.name,
                                  surname: SignUpForm.surname)),
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
                                  Text(widget.emailLabelText),
                                ],
                              ),
                              labelStyle: theme.textTheme.bodySmall!.copyWith(),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            formControlName: 'email',
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
                                  surname: SignUpForm.surname)),
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
                                  Text(widget.passwordLabelText),
                                ],
                              ),
                              labelStyle: theme.textTheme.bodySmall,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            formControlName: 'password',
                          ),
                        ),

                        Container(height: height / 7),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  return Center(
                                      child: InkWell(
                                        onTap: () async {
                                          if(form.valid){
                                            Navigator.of(context).push(SlideAnimationRoute(MemeScreen()));
                                          } else{
                                            form.control('email').markAllAsTouched();
                                            form.control('password').markAllAsTouched();
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
