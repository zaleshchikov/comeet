import 'dart:convert';

import 'package:comeet/models/tests/TestResultOption.dart';
import 'package:comeet/models/tests/question_model.dart';
import 'package:comeet/models/tests/test_prewiew.dart';

class Test extends TestPreview {
  List<TestResultOption> testResultOptions;
  List<Question> questions;

  Test(
      super.id,
      super.label,
      super.numberOfResults,
      super.description,
      super.color,
      super.image,
      super.testResult,
      this.testResultOptions,
      this.questions);

  factory Test.fromJson(jsCoded) {
    var jsSuper = jsonDecode(jsCoded);
    var js = jsonDecode(jsCoded);
    TestPreview testPreview = TestPreview.fromJson(jsSuper);

    return Test(
        testPreview.id,
        testPreview.label,
        testPreview.numberOfResults,
        testPreview.description,
        testPreview.color,
        testPreview.id,
        testPreview.testResult,
        List<TestResultOption>.from(js['TestResultOptions']
            .map((model) => TestResultOption.fromJson(model))),
        List<Question>.from(
            js['Question'].map((model) => Question.fromJson(model))));
  }
}
