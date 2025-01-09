part of 'start_test_bloc.dart';

class StartTestEvent {}

class SetTags extends StartTestEvent{
  List<String> tags;

  SetTags(this.tags);
}