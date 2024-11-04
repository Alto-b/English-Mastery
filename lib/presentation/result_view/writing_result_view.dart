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
            icon: const Icon(Icons.home)),
        title: Text(title),
      ),
      body: BlocBuilder<WritingBloc, WritingState>(
        builder: (context, state) {
          if (state is Writing1OutPutSuccessState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Gap(35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Band score : ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey),
                        ),
                        const Gap(10),
                        Text(
                          state.writing1CheckGrammarModel.bandScore.toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Text(state.writing1evaluateModel.feedback ?? ""),
                    const Gap(20),
                    const Divider(),
                    const Gap(20),
                    const Text(
                      "Corrected text",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    const Gap(15),
                    Text(
                      state.writing1CheckGrammarModel.correctedText.toString(),
                    ),
                    const Gap(30)
                  ],
                ),
              ),
            );
          } else if (state is WritingErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
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
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const Text(
                "Analyzing...",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ));
        },
      ),
    );
  }
}
