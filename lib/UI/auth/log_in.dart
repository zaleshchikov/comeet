import 'package:comeet/UI/auth/recover_password.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_form.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../animation/animation_one.dart';
import '../navigation/botoom_navigation.dart';
import '../profile/profile/profile_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                    backgroundColor: loginColor,
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
                            Text(
                              'С возвращением!',
                              style: theme.textTheme.titleLarge,
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
                                    labelText: 'введите почту',
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
                            Container(
                                height: size.height / 12,
                                width: size.width * 0.7,
                                child: Center(
                                    child: ReactiveTextField(
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        'Чего-то тут не хватает',
                                  },
                                  style: theme.textTheme.bodySmall,
                                  cursorColor: theme.textTheme.bodySmall!.color,
                                  decoration: InputDecoration(
                                    errorStyle: theme.textTheme.labelLarge!
                                        .copyWith(color: Color(0xffc20000)),
                                    labelText: 'вспомните пароль',
                                    labelStyle: theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: bottomNavigationColorDark
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w600),
                                    helperText: state.isError
                                        ? 'Ошибка авторизации'
                                        : '',
                                    helperStyle: theme.textTheme.labelLarge!
                                        .copyWith(color: Color(0xffc20000)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  formControlName: 'password',
                                ))),
                            Container(height: size.height / 30),
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
                                        color: purpuleColor),
                                    child: Center(
                                      child: state.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'войти',
                                              style: theme.textTheme.titleSmall,
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Container(height: size.height / 100),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    SlideAnimationRoute(RecoverPassword()));
                              },
                              child: Center(
                                child: Text(
                                  'забыли пароль?',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: bottomNavigationColorDark
                                          .withOpacity(0.5),
                                      fontWeight: FontWeight.w600),
                                ),
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
