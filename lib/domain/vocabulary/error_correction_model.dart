class ErrorCorrectionModel {
  ErrorCorrectionModel({
    required this.task,
    required this.description,
    required this.questions,
    required this.answers,
  });

  final String? task;
  final String? description;
  final Map<String, String> questions;
  final List<Answer> answers;

  factory ErrorCorrectionModel.fromJson(Map<String, dynamic> json) {
    return ErrorCorrectionModel(
      task: json["task"],
      description: json["description"],
      questions: Map.from(json["questions"])
          .map((k, v) => MapEntry<String, String>(k, v)),
      answers: json["answers"] == null
          ? []
          : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "task": task,
        "description": description,
        "questions":
            Map.from(questions).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "answers": answers.map((x) => x.toJson()).toList(),
      };
}

class Answer {
  Answer({
    required this.incorrect,
    required this.correct,
  });

  final String? incorrect;
  final String? correct;

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      incorrect: json["incorrect"],
      correct: json["correct"],
    );
  }

  Map<String, dynamic> toJson() => {
        "incorrect": incorrect,
        "correct": correct,
      };
}
