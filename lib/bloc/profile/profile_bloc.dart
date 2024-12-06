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
            User('', '', 'assets/test_images/test1.jpeg', '', 0))) {
    on<GetProfileData>(_onGetData);
  }
}

_onGetData(GetProfileData event, Emitter<ProfileState> emit) async {
  var utoken = await updateToken();
  var token = await getToken();

  var response = await http.get(
    Uri.parse(myProfile),
    headers: JsonContentHeaders(token),
  );
  
  if(response.statusCode == 200){
    var rBody = jsonDecode(response.body);
    emit(ProfileState(User(rBody['name']??'Добавьте имя', rBody['description']??'Добавьте описание', rBody['image']??'assets/test_images/test1.jpeg', rBody['profession']??'Добавьте профессию', 0)));
  }
  debugPrint(response.body);

}
