part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
  final String name;
  final String profession;
  final String email;
  final String password;
  final bool isLoading;
  bool isSuccessRequest;
  bool isError;
  int yearsOfWorking;
  int yearsOld;
  int humanHeight;

  SignUpState(
      {required this.name,
      required this.profession,
      required this.email,
      required this.password,
      this.isLoading = false,
      this.isSuccessRequest = false,
      this.isError = false,
      required this.humanHeight,
      required this.yearsOld,
      required this.yearsOfWorking});
}
