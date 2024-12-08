import 'dart:convert';
import 'dart:ui';

import 'package:comeet/models/users/user_model.dart';
import 'package:comeet/request_constant/colors.dart';
import 'package:flutter/material.dart';

class Event{
  String name;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  bool isLiked;
  List<User> people;
  String photo;
  Color color;

  Event(this.name, this.description, this.dateStart, this.dateEnd, this.isLiked, this.people, this.photo, this.color);

  static Event fromJson(data){
    return Event(data['label'],data['description'], DateTime.parse(data['startsAt']), DateTime.parse(data['endsAt']), false, [], data['image'] == null || data['image'] == '' ? '' : data['image'], data['color'] == '' ? getRandomColor() : data['color']);
  }

  static List<Event> getEventsFromJson(String jsonData){
    var data = jsonDecode(jsonData);
    List<Event> returnedData = [];
    for(var i in data){
      returnedData.add(Event.fromJson(i));
    }
    return returnedData;
  }
}