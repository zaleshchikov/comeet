import 'package:bloc/bloc.dart';
import 'package:comeet/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../request_constant/request_constant.dart';

part 'start_test_event.dart';
part 'start_test_state.dart';

class StartTestBloc extends Bloc<StartTestEvent, StartTestState> {
  StartTestBloc() : super(StartTestState()) {
    on<SetTags>(_onSetTags);
  }

  _onSetTags(SetTags event, Emitter<StartTestState> emit) async {
    emit(StartTestState(isLoading: true));
    var tags = await SignUpBloc.getAllTag();
    tags = tags!.toList();
    var token = await getToken();

    for (var eventTag in event.tags) {
      var tagId = tags.where((e) => e.name == eventTag).first.id;

      var response = await http.post(Uri.parse(tag),
          headers: JsonContentHeaders(token), body: {"tagId": tagId});
      debugPrint(response.body);
    }
    emit(StartTestState(successRequest: true));
  }
}
