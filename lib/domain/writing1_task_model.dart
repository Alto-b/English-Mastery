class Writing1GenerateTaskModel {
  String? question;
  String? sampleAnswer;
  String? imageUrl;

  Writing1GenerateTaskModel({this.question, this.sampleAnswer, this.imageUrl});

  Writing1GenerateTaskModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    sampleAnswer = json['sample_answer'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['sample_answer'] = this.sampleAnswer;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
