import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/tests/test_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../request_constant/request_constant.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState(null)) {
    on<onGetTest>(_onGetTest);
    on<UpdateTestResult>(_onUpdateTestResult);
  }

  _onGetTest(
      onGetTest event, Emitter<TestState> emit) async {
    emit(TestState(state.test, isLoading: true));

    var token = await getToken();

    var response = await http.get(
      Uri.parse(test + event.id),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      emit(TestState(Test.fromJson(json)));

      fillTestResult();
    }
    emit(TestState(Test.fromJson(json), isLoading: false, isSuccessRequest: true));
  }

  _onUpdateTestResult(
      UpdateTestResult event, Emitter<TestState> emit) async {

    var testResult = state.testResults;
    testResult![event.tagId] = event.weight + testResult[event.tagId]!;
    emit(TestState(state.test, testResults: testResult));
  }

  _onSendTestResult(
      SendTestResult event, Emitter<TestState> emit) async {
    emit(TestState(state.test, isLoading: true));

    var token = await getToken();
    var testResult = state.testResults;
    sortTestResult(testResult);

    var response = await http.post(
      Uri.parse(testResultURL),
      headers: JsonContentHeaders(token),
      body: {
        "testId": state.test!.id,
        "resultTagIds": testResult!.keys.toList().sublist(0, state.test!.numberOfResults)
      }
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      emit(TestState(Test.fromJson(json)));
    }
  }

  void fillTestResult(){
    for(var resultOption in state.test!.testResultOptions){
      var testResults = <String, int>{};
      testResults[resultOption.tagId] = 0;
      emit(TestState(state.test, testResults: testResults));
    }
  }

  void sortTestResult(testResult){

    var mapEntries = testResult.entries.toList()
      ..sort((b, a) => a.value.compareTo(b.value));
    testResult
      ..clear()
      ..addEntries(mapEntries);
  }

}
