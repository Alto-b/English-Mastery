import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:flutter/material.dart';

class PhrasalVerbsView extends StatefulWidget {
  const PhrasalVerbsView({
    super.key,
    required this.state,
  });
  final VocabularyPhrasalVerbsState state;

  @override
  _PhrasalVerbsViewState createState() => _PhrasalVerbsViewState();
}

class _PhrasalVerbsViewState extends State<PhrasalVerbsView> {
  // This list keeps track of the visibility status of each answer
  late List<bool> _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers = List.filled(
        widget.state.phrasalVerbsModel.first.questions.length, false);
  }

  // Helper method to parse and emphasize text within <u></u> tags
  Widget parseAndHighlight(String text) {
    // Regular expression to find text within <u></u> tags
    final regex = RegExp(r'<u>(.*?)<\/u>');
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      );
    }

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (var match in matches) {
      // Text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ));
      }

      // Underlined and bold text
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ));

      lastMatchEnd = match.end;
    }

    // Text after the last match
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
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
              widget.state.phrasalVerbsModel.first.task ?? "Context Clues Task",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.phrasalVerbsModel.first.description ??
                  "Context clues description",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.state.phrasalVerbsModel.first.questions.length,
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
                        // Use parseAndHighlight method to display the question with highlighted text
                        Text(widget.state.phrasalVerbsModel.first
                                .questions[index].sentence ??
                            "sentence"),
                        const SizedBox(height: 8),
                        Text(
                          widget.state.phrasalVerbsModel.first.questions[index]
                              .options
                              .toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        // parseAndHighlight(widget.state.idiomPhrasesModel.first
                        //         .questions[index].options
                        //         .toString() ??
                        //     "Question text"),
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
                            "Answer: ${widget.state.phrasalVerbsModel.first.answers[index] ?? "Answer text"}",
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
