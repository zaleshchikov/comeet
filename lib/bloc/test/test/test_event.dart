part of 'test_bloc.dart';

class TestEvent {}

class onGetTest extends TestEvent {
  String id;

  onGetTest(this.id);
}

class UpdateTestResult extends TestEvent{
}

class SendTestResult extends TestEvent{}

class AddAnswer extends TestEvent{
  int index;
  AnswerOption answer;

  AddAnswer(this.index, this.answer);
}