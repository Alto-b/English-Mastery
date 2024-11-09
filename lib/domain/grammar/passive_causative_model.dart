class PassiveCausativeModel {
  PassiveCausativeModel({
    required this.task,
    required this.description,
    required this.questions,
    required this.answers,
  });

  final String? task;
  final String? description;
  final List<String> questions;
  final List<List<String>> answers;

  factory PassiveCausativeModel.fromJson(Map<String, dynamic> json) {
    return PassiveCausativeModel(
      task: json["task"],
      description: json["description"],
      questions: json["questions"] == null
          ? []
          : List<String>.from(json["questions"]!.map((x) => x)),
      answers: json["answers"] == null
          ? []
          : List<List<String>>.from(json["answers"]!.map(
              (x) => x == null ? [] : List<String>.from(x!.map((x) => x)))),
    );
  }

  Map<String, dynamic> toJson() => {
        "task": task,
        "description": description,
        "questions": questions.map((x) => x).toList(),
        "answers": answers.map((x) => x.map((x) => x).toList()).toList(),
      };
}
