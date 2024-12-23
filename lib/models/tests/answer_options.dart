
class AnswerOption {
  final String id;
  final String text;
  final int weight;
  final String questionId;

  AnswerOption({
    required this.id,
    required this.text,
    required this.weight,
    required this.questionId,
  });

  factory AnswerOption.fromJson(json) {
    return AnswerOption(
      id: json['id'],
      text: json['text'],
      weight: int.parse(json['weight']),
      questionId: json['questionId'],
    );
  }

}