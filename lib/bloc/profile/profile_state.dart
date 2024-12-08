part of 'profile_bloc.dart';

@immutable
class ProfileState {
  User profile;
  bool isLoading;
  bool isSuccessRequest;

  ProfileState(this.profile, {this.isSuccessRequest = false, this.isLoading = false});
}

