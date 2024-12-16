part of 'event_bloc.dart';

@immutable
class EventState {
  List<Event> events;
  bool isLoading;
  bool successRequest;

  EventState({required this.events, this.isLoading = false, this.successRequest = false});
}

