class PhrasalVerbsModel {
  PhrasalVerbsModel({
    required this.task,
    required this.description,
    required this.questions,
    required this.answers,
  });

  final String? task;
  final String? description;
  final List<Question> questions;
  final List<String> answers;

  factory PhrasalVerbsModel.fromJson(Map<String, dynamic> json) {
    return PhrasalVerbsModel(
      task: json["task"],
      description: json["description"],
      questions: json["questions"] == null
          ? []
          : List<Question>.from(
              json["questions"]!.map((x) => Question.fromJson(x))),
      answers: json["answers"] == null
          ? []
          : List<String>.from(json["answers"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "task": task,
        "description": description,
        "questions": questions.map((x) => x?.toJson()).toList(),
        "answers": answers.map((x) => x).toList(),
      };
}

class Question {
  Question({
    required this.sentence,
    required this.options,
  });

  final String? sentence;
  final List<String> options;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      sentence: json["sentence"],
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "sentence": sentence,
        "options": options.map((x) => x).toList(),
      };
}
