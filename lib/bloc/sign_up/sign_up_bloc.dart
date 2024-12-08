import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../request_constant/request_constant.dart';
import 'sign_up_form.dart';
import 'package:http/http.dart' as http;
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState(email: '', password: '', isLoading: false, name: '', profession: '')) {
    on<SignUpDataEvent>(_onUpdateData);
    on<SendSignUpDataEvent>(_onSendData);
    on<SignUpDataEmailEvent>(_onUpdateDataEmail);
  }

  _onUpdateData(SignUpDataEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: event.name, profession: event.profession, email: state.email, password: state.password, isLoading: false));
  }
  _onUpdateDataEmail(SignUpDataEmailEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(name: state.name, profession: state.profession,
        email: event.email, password: event.password, isLoading: false));
  }
  _onSendData(SendSignUpDataEvent event, Emitter<SignUpState> emit) async {

      emit(SignUpState(
        name: state.name, profession: state.profession,
          email: state.email, password: state.password, isLoading: true));
      var response = await http.post(Uri.parse(registerNewUserUrl),
          headers: headers,
          body: jsonEncode({
            "email": state.email,
            "password": state.password,
            "color": getRandomColor().toString()
          }));

      emit(SignUpState(name: state.name, profession: state.profession,email: state.email, password: state.password));

      debugPrint('email: ${state.email}');
      debugPrint('password: ${state.password}');
      debugPrint(response.statusCode.toString() + response.body);

      if (response.statusCode == 200) {
        var response = await http.post(
            Uri.parse(loginUrl),
            headers: headersUrlencoded,
            body: {
              "email": state.email,
              "password": state.password,
              "profession": state.profession,
              "name": state.name
            });

        if(response.statusCode == 200){
          var resBody = jsonDecode(response.body);
          _saveToken(resBody['accessToken'], resBody['refreshToken']);
          var response2 = await http
              .patch(Uri.parse(profile), headers: JsonContentHeaders(resBody['accessToken']), body: {
            "name": state.name,
            "profession": state.profession,
          });
        }
        emit(SignUpState(name: state.name, profession: state.profession,
            email: state.email,
            password: state.password,
            isSuccessRequest: true));
      }

  }

  _saveToken(String accessToken, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }
}
