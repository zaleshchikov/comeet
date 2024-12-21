import 'dart:convert';

class TestResultOption {
  final String id;
  final String image;
  final String text;
  final String testId;
  final String tagId;

  TestResultOption(
    this.id,
    this.image,
      this.text,
    this.testId,
    this.tagId,
  );

  factory TestResultOption.fromJson(js){
    return TestResultOption(js['id'], js['image'], js['text'], js['testId'], js['tagId']);
  }
}