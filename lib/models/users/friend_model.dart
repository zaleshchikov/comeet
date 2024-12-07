import 'user_model.dart';
import 'package:flutter/material.dart';

class Friend extends User {
  Color color;

  Friend(super.name, super.description, super.photo, super.profession, super.id,
      this.color);

  static List<Friend> friendsFromUser(List<User> users) {
    List<Friend> returnFriends = [];
    for (var i in users) {
      returnFriends.add(
          Friend(i.name, i.description, i.photo, i.profession, i.id, i.color));
    }
    return returnFriends;
  }
}
