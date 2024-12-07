import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var rToken = prefs.getString('refreshToken');
  var token = prefs.getString('accessToken');
    var response = await http.post(
        Uri.parse(refreshToken),
        headers: headers,
        body: jsonEncode({
          'refreshToken': rToken
        })
    );
    if(response.statusCode == 200) {
      var accessToken = jsonDecode(response.body)['accessToken'];
      var refreshToken = jsonDecode(response.body)['refreshToken'];
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('refreshToken', refreshToken);

    }
    debugPrint(response.body);
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken') ?? '';
}

JsonContentHeaders(String token) {
  return {'Authorization': "bearer $token"};
}
const headers = {'content-type': 'application/json'};
final headersUrlencoded = {'content-type': 'application/x-www-form-urlencoded'};
final headersMedial = {'content-type': 'application/x-www-form-urlencoded'};
const myProfile = '$mainUrl/api/user/me';
const findUser = '$mainUrl/api/user/find';
const friendURL = '$mainUrl/api/user/friends';
const registerURL = '$mainUrl/api/auth/register';
const publicMedia = '$mainUrl/public_goal/set_primary_image/';
const privateMedia = '$mainUrl/private_goal/set_primary_image/';
const refreshToken = '$mainUrl/api/auth/refresh';
const mainUrl = 'http://84.201.181.110:8081';
const registerNewUserUrl = '$mainUrl/api/auth/register';
const loginUrl = '$mainUrl/api/auth/login';
const allEvent = '$mainUrl/api/event';
const myEvent = '$mainUrl/api/event/my';
const logoutUrl = '$mainUrl/auth/jwt/logout';
const forgotPassword = '$mainUrl/auth/forgot-password';
const resetPassword = '$mainUrl/auth/reset-password';
const createPrivateGoal = '$mainUrl/private_goal/';
const createPublicGoal = '$mainUrl/public_goal/';
const myGoals = '${createPublicGoal}my_goals/';
const createTask = '$mainUrl/daily_task/';
const privatTask = '$mainUrl/private_task/';
const dummyUser = '$mainUrl/auth/get_dummy_user';
const comments = '$mainUrl/comment/';
const user = '$mainUrl/users/';
const follow = '$mainUrl/follow/';

