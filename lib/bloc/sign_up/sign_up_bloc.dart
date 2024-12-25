import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/tag/tag.dart';
import '../../request_constant/request_constant.dart';
import 'sign_up_form.dart';
import 'package:http/http.dart' as http;

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(SignUpState(
            email: '',
            password: '',
            isLoading: false,
            name: '',
            profession: '',
            yearsOfWorking: 5,
            yearsOld: 20,
            humanHeight: 170)) {
    on<SignUpDataEvent>(_onUpdateData);
    on<SendSignUpDataEvent>(_onSendData);
    on<SignUpDataEmailEvent>(_onUpdateDataEmail);
    on<LogInEvent>(_onLogIn);
    on<ChangeHeight>(_onChangeHeight);
    on<ChangeYearsOld>(_onChangeYearsOld);
    on<ChangeYearsOfWorkingOld>(_onChangeYearsOfWorkingOld);
  }

  _onChangeHeight(ChangeHeight event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        isLoading: false,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: event.height));
  }

  _onChangeYearsOld(ChangeYearsOld event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        isLoading: false,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: event.years,
        humanHeight: state.humanHeight));
  }

  _onChangeYearsOfWorkingOld(
      ChangeYearsOfWorkingOld event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        isLoading: false,
        yearsOfWorking: event.years,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));
  }

  _onUpdateData(SignUpDataEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: event.name,
        profession: event.profession,
        email: state.email,
        password: state.password,
        isLoading: false,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));
  }

  _onUpdateDataEmail(SignUpDataEmailEvent event, Emitter<SignUpState> emit) {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: event.email,
        password: event.password,
        isLoading: false,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));
  }

  _onSendData(SendSignUpDataEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        isLoading: true,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));
    var response = await http.post(Uri.parse(registerNewUserUrl),
        headers: headers,
        body: jsonEncode({
          "email": state.email,
          "password": state.password,
          "color": getRandomColor().toString()
        }));

    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));

    debugPrint('email: ${state.email}');
    debugPrint('password: ${state.password}');
    debugPrint(response.statusCode.toString() + response.body);

    if (response.statusCode == 200) {
      var response = await http
          .post(Uri.parse(loginUrl), headers: headersUrlencoded, body: {
        "email": state.email,
        "password": state.password,
        "profession": state.profession,
        "name": state.name
      });

      if (response.statusCode == 200) {
        var resBody = jsonDecode(response.body);
        _saveToken(resBody['accessToken'], resBody['refreshToken']);
        var response2 = await http.patch(Uri.parse(profile),
            headers: JsonContentHeaders(resBody['accessToken']),
            body: {
              "name": state.name,
              "profession": state.profession,
            });

        setTags();
      }

      emit(SignUpState(
          name: state.name,
          profession: state.profession,
          email: state.email,
          password: state.password,
          isSuccessRequest: true,
          yearsOfWorking: state.yearsOfWorking,
          yearsOld: state.yearsOld,
          humanHeight: state.humanHeight));
    }
  }

  _onLogIn(LogInEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpState(
        name: state.name,
        profession: state.profession,
        email: state.email,
        password: state.password,
        isLoading: true,
        isError: false,
        yearsOfWorking: state.yearsOfWorking,
        yearsOld: state.yearsOld,
        humanHeight: state.humanHeight));

    var response =
        await http.post(Uri.parse(loginUrl), headers: headersUrlencoded, body: {
      "email": event.email,
      "password": event.password,
    });

    if (response.statusCode == 200) {
      var resBody = jsonDecode(response.body);
      _saveToken(resBody['accessToken'], resBody['refreshToken']);

      emit(SignUpState(
          name: state.name,
          profession: state.profession,
          email: state.email,
          password: state.password,
          isSuccessRequest: true,
          yearsOfWorking: state.yearsOfWorking,
          yearsOld: state.yearsOld,
          humanHeight: state.humanHeight));
    } else {
      emit(SignUpState(
          name: state.name,
          profession: state.profession,
          email: state.email,
          password: state.password,
          isError: true,
          yearsOfWorking: state.yearsOfWorking,
          yearsOld: state.yearsOld,
          humanHeight: state.humanHeight));
    }
  }

  Future<void> setTags() async {
    var allTags = await getAllTag();

    if (allTags != null) {
      var idHeight = allTags
          .where((e) =>
              e.name.contains("height") &&
              e.name.contains(state.humanHeight.toString()))
          .first
          .id;
      var idExp = allTags
          .where((e) =>
              e.name.contains("experience") &&
              e.name.contains(state.yearsOfWorking.toString()))
          .first
          .id;
      var idOld = allTags
          .where((e) =>
              e.name.contains("old") &&
              e.name.contains(state.yearsOld.toString()))
          .first
          .id;

      var token = await getToken();

      var response = await http
          .patch(Uri.parse(profile), headers: JsonContentHeaders(token), body: {
        "tagId": idHeight,
      });

      response = await http
          .patch(Uri.parse(profile), headers: JsonContentHeaders(token), body: {
        "tagId": idExp,
      });

      response = await http
          .patch(Uri.parse(profile), headers: JsonContentHeaders(token), body: {
        "tagId": idOld,
      });
    }
  }

  static Future<List<Tag>?> getAllTag() async {
    var token = await getToken();

    var response =
        await http.get(Uri.parse(allTag), headers: JsonContentHeaders(token));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Tag.fromJson(e))
          .toList();
    }
    return null;
  }

  _saveToken(String accessToken, String refreshToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }
}
