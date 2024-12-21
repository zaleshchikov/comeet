import 'dart:convert';

import 'package:comeet/models/tests/answer_options.dart';

class Question {
  final String id;
  final String type;
  final String text;
  final String testId;
  final String testResultOptionsId;
  final List<AnswerOption> answerOption;

  Question({
    required this.id,
    required this.type,
    required this.text,
    required this.testId,
    required this.testResultOptionsId,
    required this.answerOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      type: json['type'],
      text: json['text'],
      testId: json['testId'],
      testResultOptionsId: json['testResultOptionsId'],
      answerOption: List<AnswerOption>.from(
          json['AnswerOption'].map((model) => AnswerOption.fromJson(model))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'text': text,
      'testId': testId,
      'testResultOptionsId': testResultOptionsId,
      'AnswerOption': answerOption,
    };
  }
}