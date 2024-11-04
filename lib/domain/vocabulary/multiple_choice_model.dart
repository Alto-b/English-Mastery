class MultipleChoiceModel {
  MultipleChoiceModel({
    required this.task,
    required this.description,
    required this.questions,
    required this.answers,
  });

  final String? task;
  final String? description;
  final Map<String, Question> questions;
  final List<Answer> answers;

  factory MultipleChoiceModel.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceModel(
      task: json["task"],
      description: json["description"],
      questions: Map.from(json["questions"])
          .map((k, v) => MapEntry<String, Question>(k, Question.fromJson(v))),
      answers: json["answers"] == null
          ? []
          : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "task": task,
        "description": description,
        "questions": Map.from(questions)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "answers": answers.map((x) => x?.toJson()).toList(),
      };
}

class Answer {
  Answer({
    required this.questionNo,
    required this.answer,
  });

  final String? questionNo;
  final String? answer;

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionNo: json["question_no"],
      answer: json["answer"],
    );
  }

  Map<String, dynamic> toJson() => {
        "question_no": questionNo,
        "answer": answer,
      };
}

class Question {
  Question({
    required this.question,
    required this.options,
  });

  final String? question;
  final List<String> options;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json["question"],
      options: json["options"] == null
          ? []
          : List<String>.from(json["options"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "options": options.map((x) => x).toList(),
      };
}
