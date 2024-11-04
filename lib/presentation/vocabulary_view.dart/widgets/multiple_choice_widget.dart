import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleChoiceView extends StatefulWidget {
  const MultipleChoiceView({
    super.key,
    required this.state,
  });
  final VocabularyMultipleChoicState state;

  @override
  _MultipleChoiceViewState createState() => _MultipleChoiceViewState();
}

class _MultipleChoiceViewState extends State<MultipleChoiceView> {
  // This list keeps track of the visibility status of each answer
  late List<bool> _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers = List.filled(
        widget.state.multipleChoiceModel.first.questions.length, false);
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
            const Text(
              "Multiple Choice Task",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.multipleChoiceModel.first.task ??
                  "Multiple Choice Task",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.multipleChoiceModel.first.description ??
                  "Multiple Choice description",
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
                  widget.state.multipleChoiceModel.first.questions.length,
              itemBuilder: (context, index) {
                // Access each question as a Question object
                final questionData = widget
                    .state.multipleChoiceModel.first.questions["${index + 1}"];
                final questionText = questionData?.question ?? "";
                final options = questionData?.options ?? [];

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Question ${index + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blueAccent,
                              ),
                            ), // Toggle button to reveal or hide the answer
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showAnswers[index] = !_showAnswers[index];
                                });
                              },
                              child: Text(
                                _showAnswers[index]
                                    ? "Hide Answer"
                                    : "Show Answer",
                                style: const TextStyle(
                                    color: Colors.blueAccent, fontSize: 12),
                              ),
                            ),
                          ],
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
                        // Display each option
                        ...options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 8),

                        // Conditionally show the answer based on _showAnswers[index]
                        if (_showAnswers[index])
                          Text(
                            "Answer: ${widget.state.multipleChoiceModel.first.answers[index].answer}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
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
