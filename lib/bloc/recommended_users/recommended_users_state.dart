part of 'recommended_users_bloc.dart';


class RecommendedUsersState {
  bool isLoading;
  List<RecommendedUser> recommendedUsers;

  RecommendedUsersState(this.recommendedUsers, {this.isLoading = false});
}

