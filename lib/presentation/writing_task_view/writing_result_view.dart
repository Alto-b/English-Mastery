import 'package:english_mastery/application/writing_bloc/writing_bloc.dart';
import 'package:english_mastery/presentation/home_view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WritingResultView extends StatelessWidget {
  const WritingResultView(
      {super.key, required this.title, required this.user_answer});
  final String title;
  final String user_answer;

  // Helper method to enhance text wrapped with ** **
  Widget formattedText(String text) {
    final textSpans = <TextSpan>[];

    final regex = RegExp(r'\*\*(.*?)\*\*'); // Match text within ** **
    int start = 0;

    for (final match in regex.allMatches(text)) {
      // Add normal text before the bold section
      if (match.start > start) {
        textSpans.add(
          TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.black87),
          ),
        );
      }

      // Add enhanced style for the matched ** ** section
      textSpans.add(
        TextSpan(
          text: match.group(1), // Text within the ** **
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent, // Enhanced color
            fontSize: 16, // Slightly larger font for emphasis
          ),
        ),
      );

      start = match.end; // Move start index after the match
    }

    // Add remaining normal text after the last bold section
    if (start < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(start),
          style: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black87),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        children: textSpans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<WritingBloc>()
        .add(Writing1OutputEvent(userInput: user_answer));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAll(const HomeScreen());
          },
          icon: const Icon(Icons.home),
        ),
        title: Text(title),
      ),
      body: BlocBuilder<WritingBloc, WritingState>(
        builder: (context, state) {
          if (state is Writing1OutPutSuccessState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Band Score",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          const Gap(10),
                          Text(
                            state.writing1CheckGrammarModel.bandScore
                                .toString(),
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Feedback",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          const Gap(10),
                          // Use formattedText method for feedback text
                          formattedText(state.writing1evaluateModel.feedback ??
                              "No feedback available."),
                        ],
                      ),
                    ),
                    const Gap(30),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Corrected Text",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          const Gap(10),
                          // Use formattedText method for corrected text
                          formattedText(state
                              .writing1CheckGrammarModel.correctedText
                              .toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WritingErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const Gap(10),
                  Text(state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 16)),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<WritingBloc>()
                          .add(Writing1OutputEvent(userInput: user_answer));
                    },
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.amber,
                              Colors.orange,
                              Colors.deepOrange
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              "Mastery AI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                const Text("Analyzing...",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
