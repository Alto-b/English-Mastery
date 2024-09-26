class Writing1EvaluateModel {
  Writing1EvaluateModel({
    required this.feedback,
  });

  final String? feedback;

  factory Writing1EvaluateModel.fromJson(Map<String, dynamic> json) {
    return Writing1EvaluateModel(
      feedback: json["feedback"],
    );
  }

  Map<String, dynamic> toJson() => {
        "feedback": feedback,
      };
}
