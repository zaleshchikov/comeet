import 'package:reactive_forms/reactive_forms.dart';

class EditProfileForm {
  static final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'profession': FormControl<String>(validators: [
      Validators.required,
    ]),
    'description': FormControl<String>(validators: [
      Validators.required,
    ]),
    'photo': FormControl<String>(validators: [
      Validators.required,
    ]),
  });



  static String get name => form.control('name').value ?? 'name null';
  static String get profession => form.control('profession').value ?? 'profession null';
  static String get description => form.control('email').value ?? 'email null';
  static String get photo => form.control('password').value ?? 'password null';
}