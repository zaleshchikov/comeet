import 'package:comeet/models/test/test_model.dart';
import 'package:comeet/models/tests/TestResultOption.dart';
import '../users/user_model.dart';

class RecommendedUser{
  User user;
  List<String> tests;
  int compatability;

  RecommendedUser(this.user, this.tests, {this.compatability = 0});
}