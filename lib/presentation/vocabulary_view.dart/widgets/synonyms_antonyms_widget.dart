import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SynonymsAntonymsView extends StatefulWidget {
  const SynonymsAntonymsView({
    super.key,
    required this.state,
  });
  final VocabularySynonymsAntonymsState state;

  @override
  _SynonymsAntonymsViewState createState() => _SynonymsAntonymsViewState();
}

class _SynonymsAntonymsViewState extends State<SynonymsAntonymsView> {
  late List<bool> _showAnswers;

  @override
  void initState() {
    super.initState();
    _showAnswers = List.filled(
        widget.state.synonymsAntonymsModel.first.questions.length, false);
  }

  // Helper method to parse and style the sentence with <u> tags
  Widget parseAndEmphasize(String sentence) {
    // Regular expression to find text within <u></u> tags
    final regex = RegExp(r'<u>(.*?)<\/u>');
    final matches = regex.allMatches(sentence);

    if (matches.isEmpty) {
      return Text(
        sentence,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      );
    }

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (var match in matches) {
      // Text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: sentence.substring(lastMatchEnd, match.start),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ));
      }

      // Underlined text
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
    if (lastMatchEnd < sentence.length) {
      spans.add(TextSpan(
        text: sentence.substring(lastMatchEnd),
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
            const Text(
              "Synonyms and Antonyms Task",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.synonymsAntonymsModel.first.task ??
                  "Synonyms and Antonyms Task",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.state.synonymsAntonymsModel.first.description ??
                  "Select the correct synonym or antonym for the underlined word.",
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
                  widget.state.synonymsAntonymsModel.first.questions.length,
              itemBuilder: (context, index) {
                final questionData =
                    widget.state.synonymsAntonymsModel.first.questions[index];
                final sentence = questionData.sentence;
                final options = questionData.options;
                final answer = questionData.answer;
                final answerType = questionData.answertype;

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
                            Row(
                              children: [
                                Text(
                                  "Question ${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "(${answerType}):",
                                  style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
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
                                    color: Colors.blueAccent, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Use parseAndEmphasize method to display sentence with emphasis
                        parseAndEmphasize(sentence ?? "sentence..."),
                        const SizedBox(height: 8),
                        ...options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 8),
                        // TextButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       _showAnswers[index] = !_showAnswers[index];
                        //     });
                        //   },
                        //   child: Text(
                        //     _showAnswers[index] ? "Hide Answer" : "Show Answer",
                        //     style: const TextStyle(color: Colors.blueAccent),
                        //   ),
                        // ),
                        if (_showAnswers[index])
                          Text(
                            "Answer: $answer",
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
