import 'package:reactive_forms/reactive_forms.dart';

class SignUpForm {
  static final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'profession': FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  static final emailForm = FormGroup({
    'email': FormControl<String>(validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  static String get name => form.control('name').value ?? 'name null';
  static String get profession => form.control('profession').value ?? 'profession null';
  static String get email => emailForm.control('email').value ?? 'email null';
  static String get password => emailForm.control('password').value ?? 'password null';
}
