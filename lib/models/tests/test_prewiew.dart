import 'dart:ui';
import 'package:comeet/models/tests/test_result.dart';
import 'package:comeet/request_constant/request_constant.dart';

class TestPreview {
  String id;
  String label;
  int numberOfResults;
  String description;
  Color color;
  String image;
  TestResult? testResult;

  TestPreview(this.id, this.label, this.numberOfResults, this.description,
      this.color, this.image, this.testResult);

  static TestPreview fromJson(js) {
    return TestPreview(
        js['id'],
        js['label'],
        js['numberOfResults'],
        js['description'],
        getColorFromString(js['color']),
        js['image'],
        js['TestResult'].length == 0 ? null : List<TestResult>.from(
            js['TestResult'].map((model) => TestResult.fromJson(model)))[0]);
  }

}
