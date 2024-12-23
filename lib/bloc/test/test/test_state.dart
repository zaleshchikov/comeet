part of 'test_bloc.dart';

class TestState {
  Test? test;
  bool isLoading;
  Map<TestResultOption, int>? testResults;
  bool isSuccessRequest;
  List? answers;

  TestState(this.test, {this.isLoading = false, this.testResults, this.isSuccessRequest = false, this.answers});
}

