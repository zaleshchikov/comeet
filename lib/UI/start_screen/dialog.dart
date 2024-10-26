import 'message.dart';

List userMessages = [
  ChatMessage(messageContent: "Это что за зверь такой?", messageType: "sender"),
  ChatMessage(messageContent: "Расскажешь мне, где я?", messageType: "sender"),
];

List bitaMessages = [
  ChatMessage(messageContent: "Если коротко - твой помощник, друг и соратник. Ну и робот я, а не зверь", messageType: "receiver"),
  ChatMessage(messageContent: "Без проблем!", messageType: "receiver"),
  ChatMessage(messageContent: "Да, в мафию. Если захочешь, конечно. Психологические тесты, сортировка коллег по интересам.. Да что я все о себе да о себе - твоя очередь. Расскажешь, кто ты?", messageType: "receiver"),
];

List userPhrases = [
  'Это что за зверь такой?',
  'Расскажешь мне, где я?',
  'Расскажу'
];