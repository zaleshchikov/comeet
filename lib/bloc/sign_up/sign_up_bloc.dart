import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../request_constant/request_constant.dart';
import 'sign_up_form.dart';
import 'package:http/http.dart' as http;

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState(email: '', password: '', isLoading: false)) {
    on<SignUpDataEvent>(_onUpdateData);
    on<SendSignUpDataEvent>(_onSendData);
  }

  _onUpdateData(SignUpDataEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        email: event.name, password: event.surname, isLoading: false));
  }

  _onSendData(SendSignUpDataEvent event, Emitter<SignUpState> emit) async {
    if (SignUpForm.form.valid) {
      emit(SignUpState(
          email: state.email, password: state.password, isLoading: true));
      var response = await http.post(Uri.parse(registerNewUserUrl),
          headers: headers,
          body: jsonEncode({
            "email": state.email,
            "password": state.password,
            "username": state.email
          }));
      emit(SignUpState(email: state.email, password: state.password));

      debugPrint('email: ${state.email}');
      debugPrint('password: ${state.password}');
      debugPrint(response.statusCode.toString() + response.body);

      if (response.statusCode == 200) {
        var response = await http.post(
            Uri.parse(loginUrl),
            headers: headersUrlencoded,
            body: {
              "username": state.email,
              "password": state.password,
            });

        emit(SignUpState(
            email: state.email,
            password: state.password,
            isSuccessRequest: true));
      }
    }
  }

  _saveDataToDB(String email, String password, String token, String nickName) async {

  }

}
