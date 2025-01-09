import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/events/event_model.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

part 'event_event.dart';

part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventState(events: [])) {
    on<GetEvents>(_getEvents);
    on<GetMyEvent>(_getMyEvents);
    on<AddEvent>(_addEvent);
    on<SubscribeEvent>(_onSubscribeEvent);
    on<UnSubscribeEvent>(_onUnSubscribeEvent);
  }

  _getEvents(GetEvents event, Emitter<EventState> emit) async {
    emit(EventState(events: state.events, isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(allEvent),
      headers: JsonContentHeaders(token),
    );

    var responseMyEvent = await http.get(
      Uri.parse(myEvent),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200 && responseMyEvent.statusCode == 200) {
      var myEventsId =
          Event.getEventsFromJson(responseMyEvent.body).map((e) => e.id);
      var events = Event.getEventsFromJson(response.body);
      for (var e in events) {
        e.isLiked = myEventsId.contains(e.id);
      }
      emit(EventState(events: events));
    }
    emit(EventState(events: state.events, isLoading: false));
    debugPrint(response.body);
  }

  _getMyEvents(GetMyEvent event, Emitter<EventState> emit) async {
    emit(EventState(events: state.events, isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http.get(
      Uri.parse(myEvent),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      emit(EventState(events: Event.getEventsFromJson(response.body)));
    }
    debugPrint(response.body);
  }

  _addEvent(AddEvent event, Emitter<EventState> emit) async {
    emit(EventState(events: state.events, isLoading: true));
    var utoken = await updateToken();
    var token = await getToken();

    var response = await http
        .post(Uri.parse(allEvent), headers: JsonContentHeaders(token), body: {
      "image": event.event.photo,
      "startsAt": event.event.dateStart.toUtc().toIso8601String(),
      "endsAt": event.event.dateStart
          .add(Duration(hours: 2))
          .toUtc()
          .toIso8601String(),
      "label": event.event.name,
      "description": event.event.description,
      "color": getRandomColor().value.toRadixString(16).substring(2, 8)
    });

    if (response.statusCode == 200) {
      emit(EventState(
          events: [...state.events, event.event],
          isLoading: false,
          successRequest: true));
    }
    debugPrint(response.body);
  }

  _onSubscribeEvent(SubscribeEvent event, Emitter<EventState> emit) async {
    var token = await getToken();

    var response = await http.post(
      Uri.parse(subscribeEvent + event.event.id),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {}
    debugPrint(response.body);
  }

  _onUnSubscribeEvent(UnSubscribeEvent event, Emitter<EventState> emit) async {
    var token = await getToken();

    var response = await http.delete(
      Uri.parse(unSubscribeEvent + event.event.id),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {}
    debugPrint(response.body);
  }
}
