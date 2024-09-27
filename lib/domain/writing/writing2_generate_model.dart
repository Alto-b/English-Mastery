class Writing2GenerateModel {
  Writing2GenerateModel({
    required this.question,
    required this.sampleAnswer,
    required this.imageUrl,
  });

  final String? question;
  final String? sampleAnswer;
  final dynamic imageUrl;

  factory Writing2GenerateModel.fromJson(Map<String, dynamic> json) {
    return Writing2GenerateModel(
      question: json["question"],
      sampleAnswer: json["sample_answer"],
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "sample_answer": sampleAnswer,
        "image_url": imageUrl,
      };
}
