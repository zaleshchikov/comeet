part of 'sign_up_bloc.dart';

@immutable
class SignUpEvent {

}

class SignUpDataEvent extends SignUpEvent{
  final String name;
  final String surname;

  SignUpDataEvent({required this.name, required this.surname});
}

class SendSignUpDataEvent extends SignUpEvent{

}
