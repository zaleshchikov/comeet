import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:comeet/models/resommended_user/recommendation.dart';
import 'package:comeet/models/resommended_user/recommended_user_model.dart';
import 'package:comeet/models/users/user_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../request_constant/request_constant.dart';

part 'recommended_users_event.dart';

part 'recommended_users_state.dart';

class RecommendedUsersBloc
    extends Bloc<RecommendedUsersEvent, RecommendedUsersState> {
  RecommendedUsersBloc() : super(RecommendedUsersState([])) {
    on<GetRecommendedUser>(_onGetRecommendedUsers);
  }

  _onGetRecommendedUsers(
      GetRecommendedUser event, Emitter<RecommendedUsersState> emit) async {
    emit(RecommendedUsersState(state.recommendedUsers, isLoading: true));

    var token = await getToken();

    var response = await http.get(
      Uri.parse(recommendedUsers),
      headers: JsonContentHeaders(token),
    );

    if (response.statusCode == 200) {
      var responseMe = await http.get(
        Uri.parse(myProfile),
        headers: JsonContentHeaders(token),
      );
      if (responseMe.statusCode == 500) {
        return;
      }
      var me = jsonDecode(responseMe.body);

      List<Recommendation> recommendationsResponse =
          jsonDecode(response.body).map((e) => Recommendation.fromJson(e)).toList().cast<Recommendation>();
      recommendationsResponse.sort((b, a) => a.compatability > b.compatability
          ? 1
          : a.compatability < b.compatability
              ? -1
              : 0);
      List<RecommendedUser> users = [];
      for (var recommendation in recommendationsResponse) {
        if(me['id'] == recommendation.userId){
          continue;
        }
        var userResponse = await http.get(
          Uri.parse(profile +'/'+ recommendation.userId),
          headers: JsonContentHeaders(token),
        );

        if (userResponse.statusCode == 200) {
          users.add(RecommendedUser(
              User.fromJsom(jsonDecode(userResponse.body)),
              recommendation.compatibleTags));
        }
      }

      emit(RecommendedUsersState(users));
    }
  }
}
