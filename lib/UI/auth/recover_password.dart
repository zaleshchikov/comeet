import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../animation/animation_one.dart';
import '../navigation/botoom_navigation.dart';
import '../profile/profile/profile_screen.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state.isSuccessRequest) {
                    Navigator.of(context).push(SlideAnimationRoute(
                        BottomNavigationScreen(ProfileScreen())));
                  }
                },
                child: ReactiveForm(
                  formGroup: SignUpForm.emailForm,
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: recoverAuthColor,
                    body: Center(
                      child: Container(
                        height: size.height / 2,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(height: size.height / 50),
                            Container(
                              padding: EdgeInsets.only(left: size.width*0.05),
                              child: Row(
                                children: [
                                  Text(
                                    'Восстановление\nпароля',
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Не переживайте!\nМы вышлем на почту инструкцию\nдля сброса пароля.',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: bottomNavigationColorDark
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(height: size.height / 30),
                            Container(
                              height: size.height / 12,
                              width: size.width * 0.7,
                              child: Center(
                                child: ReactiveTextField(
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        'Чего-то тут не хватает',
                                    ValidationMessage.email: (error) =>
                                        'Что-то тут явно не так',
                                  },
                                  style: theme.textTheme.bodySmall,
                                  cursorColor: theme.textTheme.bodySmall!.color,
                                  decoration: InputDecoration(
                                    helperText: '',
                                    labelText: '',
                                    labelStyle: theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: bottomNavigationColorDark
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w600),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  formControlName: 'email',
                                ),
                              ),
                            ),
                            ReactiveFormConsumer(
                                builder: (context, form, child) {
                              return GestureDetector(
                                onTap: () {
                                  form.markAllAsTouched();
                                  if (form.valid) {
                                    BlocProvider.of<SignUpBloc>(context).add(
                                        LogInEvent(form.control('email').value,
                                            form.control('password').value));
                                  } else {
                                    form.markAllAsTouched();
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    height: size.height / 18,
                                    width: size.width * 0.37,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: colorPinkTitle),
                                    child: Center(
                                      child: state.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'отправить',
                                              style: theme.textTheme.titleSmall,
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Center(
                              child: Text(
                                'забыли пароль?',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: bottomNavigationColorDark
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(height: size.height / 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      }),
    );
  }
}
