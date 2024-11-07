class Reading1Model {
  Reading1Model({
    required this.status,
    required this.title,
    required this.passage,
    required this.questions,
  });

  final String? status;
  final String? title;
  final String? passage;
  final List<Question> questions;

  factory Reading1Model.fromJson(Map<String, dynamic> json) {
    return Reading1Model(
      status: json["status"],
      title: json["title"],
      passage: json["passage"],
      questions: json["questions"] == null
          ? []
          : List<Question>.from(
              json["questions"]!.map((x) => Question.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "title": title,
        "passage": passage,
        "questions": questions.map((x) => x?.toJson()).toList(),
      };
}

class Question {
  Question({
    required this.questionType,
    required this.questions,
    required this.answers,
    required this.options,
  });

  final String? questionType;
  final List<String> questions;
  final List<String> answers;
  final List<List<String>> options;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionType: json["question_type"],
      questions: json["questions"] == null
          ? []
          : List<String>.from(json["questions"]!.map((x) => x)),
      answers: json["answers"] == null
          ? []
          : List<String>.from(json["answers"]!.map((x) => x)),
      options: json["options"] == null
          ? []
          : List<List<String>>.from(json["options"]!.map(
              (x) => x == null ? [] : List<String>.from(x!.map((x) => x)))),
    );
  }

  Map<String, dynamic> toJson() => {
        "question_type": questionType,
        "questions": questions.map((x) => x).toList(),
        "answers": answers.map((x) => x).toList(),
        "options": options.map((x) => x.map((x) => x).toList()).toList(),
      };
}
