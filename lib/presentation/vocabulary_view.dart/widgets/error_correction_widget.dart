import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:flutter/material.dart';

class ErrorCorrectionView extends StatefulWidget {
  const ErrorCorrectionView({
    super.key,
    required this.state,
  });
  final VocabularyErrorCorrectionState state;

  @override
  _ErrorCorrectionViewState createState() => _ErrorCorrectionViewState();
}

class _ErrorCorrectionViewState extends State<ErrorCorrectionView> {
  // List to track the visibility of answers for each question
  late List<bool> _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers = List.filled(
        widget.state.errorCorrectionModel.first.questions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              widget.state.errorCorrectionModel.first.task ??
                  "Error Correction Task",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.errorCorrectionModel.first.description ??
                  "Task description",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  widget.state.errorCorrectionModel.first.questions.length,
              itemBuilder: (context, index) {
                final questionKey = widget
                    .state.errorCorrectionModel.first.questions.keys
                    .elementAt(index);
                final questionText = widget.state.errorCorrectionModel.first
                        .questions[questionKey] ??
                    "Question text";
                final incorrectAnswer = widget.state.errorCorrectionModel.first
                        .answers[index].incorrect ??
                    "Incorrect Answer";
                final correctAnswer = widget.state.errorCorrectionModel.first
                        .answers[index].correct ??
                    "Correct Answer";

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          questionText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Toggle button to reveal or hide the correct answer
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showAnswers[index] = !_showAnswers[index];
                            });
                          },
                          child: Text(
                            _showAnswers[index] ? "Hide Answer" : "Show Answer",
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        // Conditionally show the correct answer based on _showAnswers[index]
                        if (_showAnswers[index])
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Incorrect: $incorrectAnswer",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Text(
                                "Correct: $correctAnswer",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
