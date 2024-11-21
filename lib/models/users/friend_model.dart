import 'user_model.dart';
import 'package:flutter/material.dart';
class Friend extends User{
  Color color;
  Friend(super.name, super.description, super.photo, super.profession, super.id, this.color);

}