import 'package:english_mastery/application/reading_bloc/reading_bloc.dart';
import 'package:english_mastery/presentation/reading_view/reading1/reading_result_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReadingViewWidget extends StatefulWidget {
  const ReadingViewWidget({
    super.key,
    required this.state,
  });
  final ReadingLoadingSuccessState state;

  @override
  _ReadingViewWidgetState createState() => _ReadingViewWidgetState();
}

class _ReadingViewWidgetState extends State<ReadingViewWidget> {
  // Lists for storing user inputs
  late List<String?> _truefalseanswers;
  late List<String?> _multipleChoiceAnswers;
  late List<String?> _completethesentenceanswers;
  late List<String> correct_truefalseanswers;
  late List<String> correct_multipleChoiceAnswers;
  late List<String> correct_completethesentenceanswers;

  @override
  void initState() {
    super.initState();

    // Initialize lists based on question counts in the model
    _truefalseanswers = List<String?>.filled(
      widget.state.reading1TaskModel[0].questions[0].questions.length,
      null,
    );

    _multipleChoiceAnswers = List<String?>.filled(
      widget.state.reading1TaskModel[0].questions[1].questions.length,
      null,
    );

    _completethesentenceanswers = List<String?>.filled(
      widget.state.reading1TaskModel[0].questions[2].questions.length,
      null,
    );

    // Directly assign the correct answers
    correct_truefalseanswers =
        widget.state.reading1TaskModel[0].questions[0].answers.cast<String>();
    correct_multipleChoiceAnswers =
        widget.state.reading1TaskModel[0].questions[1].answers.cast<String>();
    correct_completethesentenceanswers =
        widget.state.reading1TaskModel[0].questions[2].answers.cast<String>();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Submission"),
          content: const Text("Are you sure you want to submit your answers?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _submitAnswers();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitAnswers() {
    print("User Answers:");
    print("True/False Answers: $_truefalseanswers");
    print("Multiple Choice Answers: $_multipleChoiceAnswers");
    print("Complete the Sentence Answers: $_completethesentenceanswers");

    context.read<ReadingBloc>().add(calculateReadingScoreEvent(
        userTrueFalseAnswers: _truefalseanswers,
        userMultipleChoiceAnswers: _multipleChoiceAnswers,
        userCompleteTheSentenceAnswers: _completethesentenceanswers,
        correctTrueFalseAnswers: correct_truefalseanswers,
        correctMultipleChoiceAnswers: correct_multipleChoiceAnswers,
        correctCompleteTheSentenceAnswers: correct_completethesentenceanswers));

    Get.off(ReadingResultView());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showConfirmationDialog,
        child: const Icon(Icons.check),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: "Passage"),
                Tab(text: "QA"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Passage Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.state.reading1TaskModel.first.title}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${widget.state.reading1TaskModel.first.passage}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(height: 1.5),
                          ),
                          Gap(screenHeight / 10)
                        ],
                      ),
                    ),
                  ),

                  // QA Tab
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // True/False Questions
                          Text(
                            widget.state.reading1TaskModel[0].questions[0]
                                    .questionType ??
                                "True/False",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const Gap(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.state.reading1TaskModel[0]
                                .questions[0].questions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Icon(Icons.circle,
                                          size: 6, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.state.reading1TaskModel[0]
                                                .questions[0].questions[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio<String>(
                                                      value: "True",
                                                      groupValue:
                                                          _truefalseanswers[
                                                              index],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _truefalseanswers[
                                                              index] = value;
                                                          print(
                                                              "Updated _truefalseanswers at index $index: $_truefalseanswers");
                                                        });
                                                      },
                                                    ),
                                                    const Text('True'),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Radio<String>(
                                                      value: "False",
                                                      groupValue:
                                                          _truefalseanswers[
                                                              index],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _truefalseanswers[
                                                              index] = value;
                                                          print(
                                                              "Updated _truefalseanswers at index $index: $_truefalseanswers");
                                                        });
                                                      },
                                                    ),
                                                    const Text('False'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Gap(15),
                          const Divider(color: Colors.grey, thickness: 2),
                          const Gap(15),

                          // Multiple Choice Questions
                          Text(
                            widget.state.reading1TaskModel[0].questions[1]
                                    .questionType ??
                                "Multiple Choice",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const Gap(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.state.reading1TaskModel[0]
                                .questions[1].questions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Icon(Icons.circle,
                                          size: 6, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.state.reading1TaskModel[0]
                                                .questions[1].questions[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          const SizedBox(height: 10),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint:
                                                const Text("Select an answer"),
                                            value:
                                                _multipleChoiceAnswers[index],
                                            items: widget
                                                .state
                                                .reading1TaskModel[0]
                                                .questions[1]
                                                .options[index]
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _multipleChoiceAnswers[index] =
                                                    newValue;
                                                print(
                                                    "Updated _multipleChoiceAnswers at index $index: $_multipleChoiceAnswers");
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Gap(15),
                          const Divider(color: Colors.grey, thickness: 2),
                          const Gap(15),

                          // Complete the Sentence Questions
                          Text(
                            widget.state.reading1TaskModel[0].questions[2]
                                    .questionType ??
                                "Complete the sentence",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const Gap(10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.state.reading1TaskModel[0]
                                .questions[2].questions.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Icon(Icons.circle,
                                          size: 6, color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.state.reading1TaskModel[0]
                                                .questions[2].questions[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          const SizedBox(height: 10),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            hint:
                                                const Text("Select an answer"),
                                            value: _completethesentenceanswers[
                                                index],
                                            items: widget
                                                .state
                                                .reading1TaskModel[0]
                                                .questions[2]
                                                .options[index]
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _completethesentenceanswers[
                                                    index] = newValue;
                                                print(
                                                    "Updated _completethesentenceanswers at index $index: $_completethesentenceanswers");
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Gap(15),
                          const Divider(color: Colors.grey, thickness: 2),
                          const Gap(15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
