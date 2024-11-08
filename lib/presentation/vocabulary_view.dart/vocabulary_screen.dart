import 'package:english_mastery/application/vocabulary_bloc/vocabulary_bloc.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/collocation_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/context_clues_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/error_correction_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/idiom_phrases_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/multiple_choice_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/phrasal_verbs_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/sentence_completion_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/synonyms_antonyms_widget.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/widgets/word_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class VocabularyScreen extends StatelessWidget {
  VocabularyScreen({super.key});

  // Using ValueNotifier to hold the selected value
  final ValueNotifier<String> selectedValue =
      ValueNotifier<String>("Sentence Completion");
  final List<String> levels = [
    "Sentence Completion",
    "Error Correction",
    "Multiple Choice",
    "Synonyms Antonyms",
    "Collocations",
    "Word Forms",
    "Context Clues",
    "Idiom Phrases",
    "Phrasal Verbs"
  ];

  // Method to handle dropdown selection
  void handleSelection(BuildContext context, String selection) {
    switch (selection) {
      case "Sentence Completion":
        context
            .read<VocabularyBloc>()
            .add(VocabualarySentenceCompletionEvent());
        break;
      case "Error Correction":
        context.read<VocabularyBloc>().add(VocabualaryErrorCorrectionEvent());
        break;
      case "Multiple Choice":
        context.read<VocabularyBloc>().add(VocabularyMultipleChoiceEvent());
        break;
      case "Synonyms Antonyms":
        context.read<VocabularyBloc>().add(VocabularySynonymsAntonymsEvent());
        break;
      case "Collocations":
        context.read<VocabularyBloc>().add(VocabularyCollocationEvent());
        break;
      case "Word Forms":
        context.read<VocabularyBloc>().add(VocabularyWordFormEvent());
        break;
      case "Context Clues":
        context.read<VocabularyBloc>().add(VocabularyContextCluesEvent());
        break;
      case "Idiom Phrases":
        context.read<VocabularyBloc>().add(VocabularyIdiomPhrasesEvent());
        break;
      case "Phrasal Verbs":
        context.read<VocabularyBloc>().add(VocabularyPhrasalVerbsEvent());
        break;
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
            padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0), // Adjusted padding for better alignment
            child: BlocBuilder<VocabularyBloc, VocabularyState>(
              builder: (context, state) {
                if (state is VocabularyLoadingState) {
                  return SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Improve alignment
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Select category:",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              Colors.black87), // Improved font weight & color
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedValue,
                        builder: (context, value, _) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4), // Add vertical padding
                            decoration: BoxDecoration(
                              color: Colors.blue
                                  .shade50, // Softer background color for focus
                              borderRadius: BorderRadius.circular(
                                  12), // Slightly more rounded corners
                              border: Border.all(
                                  color: Colors.blueAccent
                                      .shade100), // Accent color for border
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ), // Add shadow for a subtle depth effect
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: value,
                                items: levels.map((String level) {
                                  return DropdownMenuItem<String>(
                                    value: level,
                                    child: Text(
                                      level,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors
                                              .black87), // Darker text for readability
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedValue.value = newValue;
                                    handleSelection(context, newValue);
                                  }
                                },
                                dropdownColor: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blueAccent,
                                  size: 28,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<VocabularyBloc, VocabularyState>(
              builder: (context, state) {
                if (state is VocabularyErrorState) {
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Lottie.asset('assets/loader/404.json'),
                        ),
                        Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                if (state is VocabularySentenceCompletionState) {
                  return SentenceCompletionView(
                    state: state,
                  );
                } else if (state is VocabularyErrorCorrectionState) {
                  return ErrorCorrectionView(state: state);
                } else if (state is VocabularyLoadingState) {
                  return const Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(
                        color: Colors.lightBlue,
                        radius: 15,
                      ),
                      Gap(15),
                      Text(
                        "Loading...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ));
                } else if (state is VocabularyMultipleChoicState) {
                  return MultipleChoiceView(state: state);
                } else if (state is VocabularySynonymsAntonymsState) {
                  return SynonymsAntonymsView(state: state);
                } else if (state is VocabularyCollocationState) {
                  return CollocationView(state: state);
                } else if (state is VocabularyWordFormsState) {
                  return WordFormView(state: state);
                } else if (state is VocabularyContextCluesState) {
                  return ContextCluesView(state: state);
                } else if (state is VocabularyIdiomPhrasesState) {
                  return IdiomPhrasesWidget(state: state);
                } else if (state is VocabularyPhrasalVerbsState) {
                  return PhrasalVerbsView(state: state);
                } else {
                  return const Center(
                    child: Text("Select a category to proceed...."),
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
