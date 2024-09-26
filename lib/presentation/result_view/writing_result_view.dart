import 'package:english_mastery/application/writing_bloc/writing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WritingResultView extends StatelessWidget {
  WritingResultView(
      {super.key, required this.title, required this.user_answer});
  final String title;
  final String user_answer;
  @override
  Widget build(BuildContext context) {
    context
        .read<WritingBloc>()
        .add(Writing1OutputEvent(userInput: user_answer));
    return Scaffold(
      appBar: AppBar(
        title: Text("${title}"),
      ),
      body: BlocBuilder<WritingBloc, WritingState>(
        builder: (context, state) {
          if (state is Writing1OutPutSuccessState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Gap(35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Band score : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey),
                        ),
                        Gap(10),
                        Text(
                          "${state.writing1CheckGrammarModel.bandScore.toString()}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Text(state.writing1evaluateModel.feedback ?? ""),
                    Gap(20),
                    Divider(),
                    Gap(20),
                    Text(
                      "Corrected text",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    Gap(10),
                    Text(state.writing1CheckGrammarModel.correctedText
                        .toString()),
                    Gap(30)
                  ],
                ),
              ),
            );
          } else if (state is WritingErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
