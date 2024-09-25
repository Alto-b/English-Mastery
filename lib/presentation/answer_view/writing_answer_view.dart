import 'package:flutter/material.dart';

class WritingAnswerView extends StatefulWidget {
  WritingAnswerView({super.key});

  @override
  _WritingAnswerViewState createState() => _WritingAnswerViewState();
}

class _WritingAnswerViewState extends State<WritingAnswerView> {
  TextEditingController answerController = TextEditingController();
  int wordCount = 0;

  @override
  void initState() {
    super.initState();
    answerController.clear();
    answerController
        .addListener(_updateWordCount); // Add listener to update word count
  }

  void _updateWordCount() {
    setState(() {
      wordCount = _calculateWordCount(answerController.text);
    });
  }

  int _calculateWordCount(String text) {
    if (text.isEmpty) {
      return 0;
    }
    return text.trim().split(RegExp(r'\s+')).length;
  }

  @override
  void dispose() {
    answerController.removeListener(_updateWordCount);
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer View"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: answerController,
                  maxLines: null, // Allows for multiline input
                  expands: true, // Expands to fill the available space
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "Enter your answer here...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text("$wordCount words"),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  elevation: MaterialStatePropertyAll(5),
                  shape: MaterialStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  // Handle the submit action here
                },
                icon: Icon(Icons.send),
                label: Text("Submit Answer"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
