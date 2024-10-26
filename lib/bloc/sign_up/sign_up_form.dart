import 'package:reactive_forms/reactive_forms.dart';

class SignUpForm {
  static final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'surname': FormControl<String>(validators: [
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

  static String get surname => form.control('surname').value ?? 'surname null';
}
