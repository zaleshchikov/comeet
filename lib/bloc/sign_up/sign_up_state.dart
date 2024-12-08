part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
  final String name;
  final String profession;
  final String email;
  final String password;
  final bool isLoading;
  bool isSuccessRequest;

  SignUpState({required this.name,required this.profession, required this.email, required this.password, this.isLoading = false, this.isSuccessRequest = false});
}


