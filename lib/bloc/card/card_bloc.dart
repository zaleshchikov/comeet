import 'package:bloc/bloc.dart';
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
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(findUser),
      headers: JsonContentHeaders(token),
    );

    if(response.statusCode == 200){
      emit(CardState(User.getEventsFromJson(response.body)));
    }
    debugPrint(response.body);
    emit(CardState(state.cards, isLoading: false));

  }

  _onUpdateData(SearchCard event, Emitter<CardState> emit) async {
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(findUser + '?email=${event.pattern}'),
      headers: JsonContentHeaders(token),
    );

    if(response.statusCode == 200){
      emit(CardState(User.getEventsFromJson(response.body)));
    }

    debugPrint(response.body);
  }



}
