import 'dart:ui';

import 'package:comeet/models/users/user_model.dart';

class Event{
  String name;
  String description;
  DateTime date;
  bool isLiked;
  List<User> people;
  String photo;
  Color color;

  Event(this.name, this.description, this.date, this.isLiked, this.people, this.photo, this.color);
}