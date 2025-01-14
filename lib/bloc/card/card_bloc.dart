import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/users/friend_model.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

part 'card_event.dart';

part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState([])) {
    on<GetCards>(_onGetData);
    on<SearchCard>(_onUpdateData);
  }

  _onGetData(GetCards event, Emitter<CardState> emit) async {
    emit(CardState(state.cards, isLoading: true));
    var token = await getToken();

    var response_user = await http.get(
      Uri.parse(findUser),
      headers: JsonContentHeaders(token),
    );

    if (response_user.statusCode == 200) {
      var response_friend = await http.get(
        Uri.parse(friendURL),
        headers: JsonContentHeaders(token),
      );

      if (response_friend.statusCode == 200) {
        var responseMe = await http.get(
          Uri.parse(myProfile),
          headers: JsonContentHeaders(token),
        );
        if (responseMe.statusCode == 500) {
          return;
        }
        var me = jsonDecode(responseMe.body);
        var users = User.getEventsFromJson(response_user.body);
        var friendsID =
            Friend.friendsFromUser(User.getEventsFromJson(response_friend.body))
                .map((e) => e.id);
        users = users
            .where((e) => !friendsID.contains(e.id) && e.id != me['id'])
            .toList();
        emit(CardState(users));
      }
    }
    debugPrint(response_user.body);
    emit(CardState(state.cards, isLoading: false));
  }

  _onUpdateData(SearchCard event, Emitter<CardState> emit) async {
    var token = await getToken();

    var response = await http.get(
      Uri.parse(findUser + '?email=${event.pattern}'),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      emit(CardState(User.getEventsFromJson(response.body)));
    }

    debugPrint(response.body);
  }
}
