import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/tag/tag.dart';
import 'package:comeet/request_constant/request_constant.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'tag_event.dart';

part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(TagState([])) {
    on<GetAllTags>(_onGetUserTags);
  }

  _onGetUserTags(GetAllTags event, Emitter<TagState> emit) async {
    emit(TagState(state.userTags, isLoading: true));
    var token = await getToken();
    var response =
    await http.get(Uri.parse(myTag), headers: JsonContentHeaders(token));

    if (response.statusCode == 200) {
      var tags = (jsonDecode(response.body) as List)
          .map((e) => Tag.fromJson(e))
          .toList();
      emit(TagState(tags));
    }
    emit(TagState(state.userTags));
    }
  }
