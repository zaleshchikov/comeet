part of 'event_bloc.dart';

@immutable
class EventEvent {}

class GetEvents extends EventEvent{

}

class GetMyEvent extends EventEvent{}

class AddEvent extends EventEvent{
  Event event;

  AddEvent(this.event);
}