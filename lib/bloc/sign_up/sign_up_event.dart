part of 'sign_up_bloc.dart';

@immutable
class SignUpEvent {

}

class SignUpDataEvent extends SignUpEvent{
  final String name;
  final String profession;

  SignUpDataEvent({required this.name, required this.profession});
}

class SendSignUpDataEvent extends SignUpEvent{

}

class SignUpDataEmailEvent extends SignUpEvent{
  final String email;
  final String password;

  SignUpDataEmailEvent({required this.email, required this.password});
}

class LogInEvent extends SignUpEvent{
  final String email;
  final String password;

  LogInEvent(this.email, this.password);
}

