import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/tests/test_prewiew.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../request_constant/request_constant.dart';

part 'test_preview_event.dart';

part 'test_preview_state.dart';

class TestPreviewBloc extends Bloc<TestPreviewEvent, TestPreviewState> {
  TestPreviewBloc() : super(TestPreviewState([])) {
    on<getTestPreviews>(_onGetTestPreview);
  }

  _onGetTestPreview(
      getTestPreviews event, Emitter<TestPreviewState> emit) async {
    emit(TestPreviewState(state.testPreviews, isLoading: true));

    var token = await getToken();

    var response = await http.get(
      Uri.parse(testPreview),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      emit(TestPreviewState(List<TestPreview>.from(
          json.map((model) => TestPreview.fromJson(model)))));
    }

    emit(TestPreviewState(state.testPreviews, isLoading: false));
  }
}
