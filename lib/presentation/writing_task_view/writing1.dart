import 'package:english_mastery/application/writing_bloc/writing_bloc.dart';
import 'package:english_mastery/presentation/answer_view/writing_answer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Writing1View extends StatelessWidget {
  const Writing1View({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WritingBloc>().add(Writing1GenerateTaskEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Writing 1"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => WritingAnswerView());
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: BlocBuilder<WritingBloc, WritingState>(
        builder: (context, state) {
          if (state is Writing1GenerateTaskSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(20),
                          Text(
                            splitWritingTask(state.writing1generateTaskModel
                                        .first.question ??
                                    "")
                                .first,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              letterSpacing: 2,
                            ),
                          ),
                          const Gap(20),
                          Text(
                            splitWritingTask(state.writing1generateTaskModel
                                        .first.question ??
                                    "")
                                .last,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              letterSpacing: 2,
                            ),
                          ),
                          const Gap(20),
                          Text(
                            splitWritingTask(state
                                    .writing1generateTaskModel.first.question ??
                                "")[1],
                            style: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight
                                  .bold, // Increased weight for emphasis
                            ),
                          ),
                          const Gap(30),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15), // Rounded corners for the image
                              child: Image.network(
                                state.writing1generateTaskModel.first
                                        .imageUrl ??
                                    "",
                                fit: BoxFit.cover, // Better image fit
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text(
                                  'Image not available',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          const Gap(20),
                          ExpansionTile(
                            trailing: Icon(Icons.add_circle_outline),
                            title: const Text("Sample Solution:"),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  state.writing1generateTaskModel.first
                                          .sampleAnswer ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Wrap(
                    spacing: 10, // Adds space between the buttons
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(5),
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          context
                              .read<WritingBloc>()
                              .add(Writing1GenerateTaskEvent());
                        },
                        icon: Icon(Icons.autorenew),
                        label: Text("Generate Question"),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green),
                          elevation: MaterialStatePropertyAll(5),
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.send),
                        label: Text("Submit Answer"),
                      ),
                    ],
                  ),
                ),
                Gap(10)
              ],
            );
          }
          if (state is WritingErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<String> splitWritingTask(String inputText) {
    // Define the part to eliminate
    String prefixToRemove = "WRITING TASK 1";

    // Find the position of the first sentence end (where "task" ends)
    int taskEndIndex = inputText.indexOf("task") + 4;

    // Find the position where the third sentence begins (where "Write at least" begins)
    int writeStartIndex = inputText.indexOf("Write at least");

    // Extract the different parts of the text
    String firstSentence =
        inputText.substring(prefixToRemove.length, taskEndIndex).trim();
    String middleSentence =
        inputText.substring(taskEndIndex, writeStartIndex).trim();
    String thirdSentence = inputText.substring(writeStartIndex);

    // Return the sentences as a list
    return [firstSentence, middleSentence, thirdSentence];
  }
}
