class SpeakingGenerateTaskModel {
  SpeakingGenerateTaskModel({
    required this.question,
  });

  final String? question;

  factory SpeakingGenerateTaskModel.fromJson(Map<String, dynamic> json) {
    return SpeakingGenerateTaskModel(
      question: json["question"],
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
      };
}
