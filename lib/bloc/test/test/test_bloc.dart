import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/tests/TestResultOption.dart';
import 'package:comeet/models/tests/answer_options.dart';
import 'package:comeet/models/tests/test_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../request_constant/request_constant.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState(null, answers: [], testResults: {})) {
    on<onGetTest>(_onGetTest);
    on<UpdateTestResult>(_onUpdateTestResult);
    on<AddAnswer>(_onAddAnswer);
    on<SendTestResult>(_onSendTestResult);
  }

  _onGetTest(
      onGetTest event, Emitter<TestState> emit) async {
    emit(TestState(state.test, isLoading: true, answers: [], testResults: state.testResults));

    var token = await getToken();

    var response = await http.get(
      Uri.parse(test + event.id),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      emit(TestState(Test.fromJson(response.body), answers: state.answers, testResults: state.testResults));
    }
    emit(TestState(state.test, isLoading: false, isSuccessRequest: true, answers: state.answers, testResults: state.testResults));
  }

  _onUpdateTestResult(
      UpdateTestResult event, Emitter<TestState> emit) async {
    fillTestResult();

    var testResult = state.testResults;
    for(var answer in state.answers!){
    for(var result in testResult!.keys) {
      if(result.id == state.test!.questions[state.answers!.indexOf(answer)].testResultOptionsId){
        testResult[result] = answer.weight + testResult[result]!;
      }}
    }
    sortTestResult(testResult!);

    emit(TestState(state.test, testResults: testResult, answers: state.answers,endTest: true));
  }

  _onAddAnswer(
      AddAnswer event, Emitter<TestState> emit) async {
    if((state.answers!.length-1) < event.index){
      state.answers!.add(event.answer);
    } else{
    state.answers![event.index] = event.answer;}
    emit(TestState(state.test, answers: state.answers, testResults: state.testResults));
  }

  _onSendTestResult(
      SendTestResult event, Emitter<TestState> emit) async {
    emit(TestState(state.test, isLoading: true, answers: state.answers, testResults: state.testResults));

    var token = await getToken();
    var testResult = state.testResults;
    sortTestResult(testResult!);
    var result = testResult!.keys.map((result) => result.tagId).toList()[0];
    var response = await http.post(
      Uri.parse(testResultURL),
      headers: JsonContentHeaders(token),
      body: {
        "testId": state.test!.id,
        "resultTagIds": //state.test!.numberOfResults == 0 ?
        result
        //: testResult!.keys.map((result) => result.tagId).toList().sublist(0, state.test!.numberOfResults)
      }
    );
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      emit(TestState(Test.fromJson(json), answers: state.answers, testResults: state.testResults));
    }
  }

  void fillTestResult(){
    var testResults = <TestResultOption, int>{};

    for(var resultOption in state.test!.testResultOptions){
      testResults[resultOption] = 0;
      emit(TestState(state.test, testResults: testResults, answers: state.answers));
    }
  }

  void sortTestResult(Map<TestResultOption, int> testResult){

    var mapEntries = testResult.entries.toList();
    mapEntries.sort((b, a) => a.value.compareTo(b.value));
    testResult
      ..clear()
      ..addEntries(mapEntries);
  }
}
