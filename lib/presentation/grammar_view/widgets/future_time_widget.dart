import 'package:english_mastery/application/grammar_bloc/grammar_bloc.dart';
import 'package:flutter/material.dart';

class FutureTimeWidget extends StatefulWidget {
  const FutureTimeWidget({
    super.key,
    required this.state,
  });
  final GrammarFutureTimeState state;

  @override
  _FutureTimeWidgetState createState() => _FutureTimeWidgetState();
}

class _FutureTimeWidgetState extends State<FutureTimeWidget> {
  // This list keeps track of the visibility status of each answer
  late List<bool> _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers =
        List.filled(widget.state.futureTimeModel.first.questions.length, false);
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
              widget.state.futureTimeModel.first.task ?? "Future time task",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            // const SizedBox(height: 8),
            // Text(
            //   widget.state.collocationModel.first.task ??
            //       "Sentence Completion Task",
            //   style: const TextStyle(
            //     fontSize: 18,
            //     color: Colors.black87,
            //   ),
            // ),
            const SizedBox(height: 8),
            Text(
              widget.state.futureTimeModel.first.description ??
                  "Future time description",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.state.futureTimeModel.first.questions.length,
              itemBuilder: (context, index) {
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
                          widget.state.futureTimeModel.first.questions[index] ??
                              "Question text",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Toggle button to reveal or hide the answer
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
                        // Conditionally show the answer based on _showAnswers[index]
                        if (_showAnswers[index])
                          Text(
                            "${widget.state.futureTimeModel.first.answers[index] ?? "Answer text"}",
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
