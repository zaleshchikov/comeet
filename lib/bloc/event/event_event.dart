part of 'event_bloc.dart';

class EventEvent {}

class GetEvents extends EventEvent{

}

class GetMyEvent extends EventEvent{}

class AddEvent extends EventEvent{
  Event event;

  AddEvent(this.event);
}

class SubscribeEvent extends EventEvent{
  Event event;

  SubscribeEvent(this.event);
}

class UnSubscribeEvent extends EventEvent{
  Event event;

  UnSubscribeEvent(this.event);
}