import 'package:english_mastery/application/grammar_bloc/grammar_bloc.dart';
import 'package:english_mastery/presentation/grammar_view/widgets/articles_quantifiers_widget.dart';
import 'package:english_mastery/presentation/grammar_view/widgets/future_time_widget.dart';
import 'package:english_mastery/presentation/grammar_view/widgets/past_time_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GrammarScreen extends StatelessWidget {
  GrammarScreen({super.key});

  // Using ValueNotifier to hold the selected value
  final ValueNotifier<String> selectedValue =
      ValueNotifier<String>("Past Time");
  final List<String> levels = [
    "Past Time",
    "Future Time",
    "Articles Quantifiers",
    "Conditionals",
    "Comparatives Superlatives",
    "Modals",
    "Passive Causative",
    "Compound Future",
    "Quantity",
    "Passive Structures",
    "Uses of it",
    "Relative Clauses",
    "Modals Speculation",
    "Talking About Ability",
    "Emphatic Forms",
    "WH Words"
  ];

  // Method to handle dropdown selection
  void handleSelection(BuildContext context, String selection) {
    switch (selection) {
      case "Past Time":
        context.read<GrammarBloc>().add(GrammarPastTimeEvent());
        break;
      case "Future Time":
        context.read<GrammarBloc>().add(GrammarFutureTimeEvent());
        break;
      case "Articles Quantifiers":
        context.read<GrammarBloc>().add(GrammarArticlesQuantifiersEvent());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grammar"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0), // Adjusted padding for better alignment
            child: BlocBuilder<GrammarBloc, GrammarState>(
              builder: (context, state) {
                // if (state is GrammarLoadingState) {
                //   return Center(

                //       child: CircularProgressIndicator(
                //       valueColor:
                //           AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                //     ),
                //       ); // Show a loader instead of an empty container
                // }
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
            child: BlocBuilder<GrammarBloc, GrammarState>(
              builder: (context, state) {
                if (state is GrammarLoadingState) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.orange,
                      radius: 25,
                    ),
                  );
                }
                if (state is GrammarErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                }
                if (state is GrammarPastTimeState) {
                  return PastTimeWidget(
                    state: state,
                  );
                }
                if (state is GrammarFutureTimeState) {
                  return FutureTimeWidget(
                    state: state,
                  );
                }
                if (state is GrammarArticlesQuantifiersState) {
                  return ArticlesQuantifiersWidget(state: state);
                }
                return Center(
                  child: Text("Select an option from the dropdown"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
