import 'package:english_mastery/presentation/result_view/writing_result_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WritingAnswerView extends StatefulWidget {
  const WritingAnswerView({super.key, this.pageTitle});

  @override
  _WritingAnswerViewState createState() => _WritingAnswerViewState();
  final pageTitle;
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
        title: Text("${widget.pageTitle}"),
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
                  decoration: const InputDecoration(
                    hintText: "Enter your answer here...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
              child: Text(
                "$wordCount words",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Colors.green),
                  elevation: const MaterialStatePropertyAll(5),
                  shape: MaterialStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  // Handle the submit action here
                  if (answerController.text.isNotEmpty) {
                    // context.read<WritingBloc>().add(Writing1CheckGrammerEvent(
                    //     user_input: answerController.text.trim()));
                    Get.to(() => WritingResultView(
                          title: widget.pageTitle,
                          user_answer: answerController.text.trim(),
                        ));
                  } else {
                    Get.snackbar("Oops!", "Enter answer to proceed",
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white);
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text("Submit Answer"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
