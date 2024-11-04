import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VocabularyScreen extends StatelessWidget {
  VocabularyScreen({super.key});

  // Using ValueNotifier to hold the selected value
  final ValueNotifier<String> selectedValue =
      ValueNotifier<String>("Sentence Completion");
  final List<String> levels = [
    "Sentence Completion",
    "Error Correction",
    "Multiple Choice"
  ];

  // Method to handle dropdown selection
  void handleSelection(BuildContext context, String selection) {
    switch (selection) {
      case "Sentence Completion":
        context
            .read<VocabularyBloc>()
            .add(VocabualarySentenceCompletionEvent());
        break;
      // Uncomment and add cases for other events as needed
      // case "Error Correction":
      //   context.read<VocabularyBloc>().add(VocabualaryErrorCorrectionEvent());
      //   break;
      // case "Multiple Choice":
      //   context.read<VocabularyBloc>().add(VocabualaryMultipleChoiceEvent());
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  "Select category:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 10),
                ValueListenableBuilder<String>(
                  valueListenable: selectedValue,
                  builder: (context, value, _) {
                    return DropdownButton<String>(
                      value: value,
                      items: levels.map((String level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedValue.value = newValue;
                          handleSelection(context, newValue);
                        }
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<VocabularyBloc, VocabularyState>(
              builder: (context, state) {
                if (state is VocabularySentenceCompletionState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            "Sentence Completion Task",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.sentenceCompletionModel.first.task ??
                                "Sentence Completion Task",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.sentenceCompletionModel.first.description ??
                                "Sentence Completion description",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state
                                .sentenceCompletionModel.first.questions.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        state.sentenceCompletionModel.first
                                                .questions[index] ??
                                            "Question text",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Answer: ${state.sentenceCompletionModel.first.answers[index] ?? "Answer text"}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
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
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
