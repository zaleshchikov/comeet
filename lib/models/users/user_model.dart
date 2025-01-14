import 'dart:convert';
import 'dart:ui';

import 'package:comeet/request_constant/request_constant.dart';
import 'package:flutter/material.dart';

class User{
  String name;
  String description;
  String photo;
  String profession;
  String id;
  Color color;

  User(this.name, this.description, this.photo, this.profession, this.id,
      {this.color = Colors.white});

  static User fromJsom(data){
    
    return User(data['name'] ?? 'Работяга без имени', data['description'] ?? 'Работяга без описания', data["image"] ?? '', data['profession'] ?? 'Работяга', data['id'] ?? '', color: getColorFromString(data['color']));
  }

  static List<User> getEventsFromJson(String jsonData){
    var data = jsonDecode(jsonData);
    List<User> returnedData = [];
    for(var i in data){
      returnedData.add(User.fromJsom(i));
    }

    return returnedData;
  }
}