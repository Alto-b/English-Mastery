class SynonymsAntonymsModel {
  SynonymsAntonymsModel({
    required this.task,
    required this.description,
    required this.questions,
  });

  final String? task;
  final String? description;
  final List<Question> questions;

  factory SynonymsAntonymsModel.fromJson(Map<String, dynamic> json) {
    return SynonymsAntonymsModel(
      task: json["task"],
      description: json["description"],
      questions: json["questions"] == null
          ? []
          : List<Question>.from(
              json["questions"]!.map((x) => Question.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "task": task,
        "description": description,
        "questions": questions.map((x) => x?.toJson()).toList(),
      };
}

class Question {
  Question({
    required this.sentence,
    required this.options,
    required this.answer,
    required this.answertype,
  });

  final String? sentence;
  final List<String> options;
  final String? answer;
  final String? answertype;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      sentence: json["sentence"],
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
      answer: json["answer"],
      answertype: json["answertype"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sentence": sentence,
        "options": options.map((x) => x).toList(),
        "answer": answer,
        "answertype": answertype,
      };
}
