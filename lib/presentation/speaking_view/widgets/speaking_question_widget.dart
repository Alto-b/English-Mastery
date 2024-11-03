import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:english_mastery/application/speaking_question_bloc/speaking_question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SpeakingQuestionWidget extends StatelessWidget {
  const SpeakingQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<SpeakingQuestionBloc>().add(Speaking2GenerateQuestionEvent());
    return BlocBuilder<SpeakingQuestionBloc, SpeakingQuestionState>(
      builder: (context, state) {
        if (state is Speaking2QuestionSuccessState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Gap(30),
                const Text("Record an audio of minimum 3 mins"),
                const Gap(25),
                Text(
                  state.speakingGenerateTaskModel.first.question ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Gap(25),
                const GenerateTaskButton(),
              ],
            ),
          );
        } else if (state is Speaking2QuestionSuccessErrorState) {
          return Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(state.message),
                    IconButton(
                        onPressed: () {
                          context
                              .read<SpeakingQuestionBloc>()
                              .add(Speaking2GenerateQuestionEvent());
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
              ),
            ),
          );
        }
        return const Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.amber), Gap(10),
                GenerateTaskButton(),
                // ElevatedButton.icon(
                //   style: ButtonStyle(
                //     elevation: const MaterialStatePropertyAll(5),
                //     shape: MaterialStatePropertyAll(
                //       ContinuousRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     context
                //         .read<SpeakingQuestionBloc>()
                //         .add(Speaking2GenerateQuestionEvent());
                //   },
                //   icon: const Icon(Icons.autorenew),
                //   label: const Text("Generate Question"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GenerateTaskButton extends StatelessWidget {
  const GenerateTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyButton(
      type: EasyButtonType.elevated,
      idleStateWidget: const Text(
        'Generate task',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      loadingStateWidget: const CircularProgressIndicator(
        strokeWidth: 3.0,
        // valueColor: AlwaysStoppedAnimation<Color>(
        //   Colors.white,
        // ),
      ),
      useWidthAnimation: true,
      useEqualLoadingStateWidgetDimension: true,
      width: 150.0,
      height: 40.0,
      borderRadius: 4.0,
      elevation: 5,
      contentGap: 6.0,
      buttonColor: Colors.blue,
      onPressed: () {
        context
            .read<SpeakingQuestionBloc>()
            .add(Speaking2GenerateQuestionEvent());
      },
    );
  }
}
