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
    on<AddFriend>(_onAddFriend);
    on<DeleteFriend>(_onRemoveFriend);
  }

  _onGetData(GetFriends event, Emitter<FriendState> emit) async {
    emit(FriendState(state.friends, isLoading: true));
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

  _onAddFriend(AddFriend event, Emitter<FriendState> emit) async {
    var token = await getToken();

    var response = await http.post(
      Uri.parse(addFriend + event.friend.id),
      headers: JsonContentHeaders(token),
    );

    var friends = state.friends;
    friends.add(event.friend);
    emit(FriendState(friends));

    debugPrint(response.body);
  }

  _onRemoveFriend(DeleteFriend event, Emitter<FriendState> emit) async {
    var token = await getToken();

    var response = await http.delete(
      Uri.parse(deleteFriend + event.friend.id),
      headers: JsonContentHeaders(token),
    );

    var friends = state.friends;
    friends.remove(state.friends.where((e) => e.id == event.friend.id).first);
    emit(FriendState(friends));

    debugPrint(response.body);
  }

}
