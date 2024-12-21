class TestResult{

  String id;
  String userId;
  String testId;
  DateTime completedAt;

  TestResult(this.id, this.userId, this.testId, this.completedAt);

  static TestResult fromJson(js){
    return TestResult(js['id'], js['userId'], js['testId'], DateTime.parse(js['completedAt']));
  }

}