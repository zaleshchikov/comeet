import 'package:bloc/bloc.dart';
import 'package:comeet/models/users/friend_model.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc() : super(FriendState([])) {
    on<GetFriends>(_onGetData);
  }

  _onGetData(GetFriends event, Emitter<FriendState> emit) async {
    emit(FriendState(state.friends, isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(friendURL),
      headers: JsonContentHeaders(token),
    );

    if(response.statusCode == 200){
      emit(FriendState(Friend.friendsFromUser(User.getEventsFromJson(response.body))));
    }
    emit(FriendState(state.friends, isLoading: false));

    debugPrint(response.body);

  }

}
