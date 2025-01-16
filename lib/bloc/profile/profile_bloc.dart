import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../request_constant/request_constant.dart';
import 'package:http/http.dart' as http;

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(
            User('', '', '', '', '0'))) {
    on<GetProfileData>(_onGetData);
    on<UpdateProfile>(_onUpdateProfile);
  }
}

_onGetData(GetProfileData event, Emitter<ProfileState> emit) async {
  emit(ProfileState(User('', '', '', '', '0'), isLoading: true));

  var utoken = await updateToken();
  var token = await getToken();
  var response = await http.get(
    Uri.parse(myProfile),
    headers: JsonContentHeaders(token),
  );

  if (response.statusCode == 200) {
    var rBody = jsonDecode(response.body);
    var im = rBody['image'] == null || rBody['image'] == ""
        ? 'assets/test_images/test1.jpeg'
        : rBody['image'];
    emit(ProfileState(User(
      rBody['name'] ?? 'Добавьте имя',
      rBody['description'] ?? 'Добавьте описание',
      rBody['image'] == null || rBody['image'] == ""
          ? ''
          : rBody['image'],
      rBody['profession'] ?? 'Добавьте профессию',
      '0',
    ), isLoading: false));
  }
  debugPrint(response.body);
}

_onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
  var utoken = await updateToken();
  var token = await getToken();
  emit(ProfileState(
      User(event.name, event.description, event.photo, event.profession, '0'),
      isLoading: true));
  var response = await http
      .patch(Uri.parse(profile), headers: JsonContentHeaders(token), body: {
    "name": event.name.trim(),
    "description": event.description.trim(),
    "profession": event.profession.trim(),
    "image": event.photo,
  });

  if (response.statusCode == 200) {
    emit(ProfileState(
        User(event.name, event.description, event.photo, event.profession, '0'),
        isSuccessRequest:  true));
  }

  debugPrint(response.body);
}
