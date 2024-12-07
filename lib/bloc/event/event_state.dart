part of 'event_bloc.dart';

@immutable
class EventState {
  List<Event> events;
  bool isLoading;

  EventState({required this.events, this.isLoading = false});
}

