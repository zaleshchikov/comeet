import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/events/event_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc()
      : super(EventState(
            events: [])) {
    on<GetEvents>(_getEvents);
  }

  _getEvents(GetEvents event, Emitter<EventState> emit) async {
    emit(EventState(
        events: state.events,
        isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(allEvent),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200){
      emit(EventState(events: Event.getEventsFromJson(response.body)));
    }
    debugPrint(response.body);
  }

  _getMyEvents(GetMyEvent event, Emitter<EventState> emit) async {
    emit(EventState(
        events: state.events,
        isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(myEvent),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200){
      emit(EventState(events: Event.getEventsFromJson(response.body)));
    }
    debugPrint(response.body);
  }
}
