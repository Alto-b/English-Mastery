class Speaking2CheckAudioResponseModel {
  Speaking2CheckAudioResponseModel({
    required this.generalFeedback,
    required this.matchFeedback,
    required this.correctedText,
    required this.status,
  });

  final String? generalFeedback;
  final String? matchFeedback;
  final String? correctedText;
  final bool? status;

  factory Speaking2CheckAudioResponseModel.fromJson(Map<String, dynamic> json) {
    return Speaking2CheckAudioResponseModel(
      generalFeedback: json["general_feedback"],
      matchFeedback: json["match_feedback"],
      correctedText: json["corrected_text"],
      status: json["status"],
    );
  }
}
