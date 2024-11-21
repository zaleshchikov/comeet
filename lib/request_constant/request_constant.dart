import 'dart:ui';

JsonContentHeaders(String token) {
  return {'content-type': 'application/json', 'Authorization': "Bearer $token"};
}
const headers = {'content-type': 'application/json'};
final headersUrlencoded = {'content-type': 'application/x-www-form-urlencoded'};
final headersMedial = {'content-type': 'application/x-www-form-urlencoded'};

const registerURL = '$mainUrl/api/auth/register';
const publicMedia = '$mainUrl/public_goal/set_primary_image/';
const privateMedia = '$mainUrl/private_goal/set_primary_image/';
const mainUrl = 'http://vladcrabserver.tplinkdns.com';
const registerNewUserUrl = '$mainUrl/auth/register';
const loginUrl = '$mainUrl/auth/jwt/login';
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
const findUser = '$mainUrl/follow/find_user/';
const follow = '$mainUrl/follow/';

