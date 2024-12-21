part of 'test_bloc.dart';

class TestState {
  Test? test;
  bool isLoading;
  Map<String, int>? testResults;
  bool isSuccessRequest;

  TestState(this.test, {this.isLoading = false, this.testResults, this.isSuccessRequest = false});
}

