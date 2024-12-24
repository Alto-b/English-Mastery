import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:english_mastery/application/speaking_question_bloc/speaking_question_bloc.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/speaking_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'speaking_result_view.dart';

class SpeakingScreenView extends StatelessWidget {
  const SpeakingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    context.read<SpeakingBloc>().add(RecordingInitial());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Speaking"),
      ),
      body: BlocListener<SpeakingBloc, SpeakingState>(
        listener: (context, state) {
          if (state is CheckAudioSuccessState) {
            // Navigate to the result view
            print("the current state is checkaudiostate");
            Get.to(() => const SpeakingResultView());
          }
        },
        child: Column(
          children: [
            const SpeakingQuestionWidget(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: BlocBuilder<SpeakingBloc, SpeakingState>(
                builder: (context, state) {
                  return Card(
                    elevation: 10,
                    shadowColor: Colors.blueAccent,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: screenHeight / 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _buildRecordingControls(context, state),
                    ),
                  );
                },
              ),
            ),
            Gap(screenHeight / 18),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingControls(BuildContext context, SpeakingState state) {
    if (state is SpeakingInitial) {
      // Initial state
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton.filled(
            onPressed: () {
              context.read<SpeakingBloc>().add(StartRecording());
            },
            icon: const Icon(
              Icons.mic,
              size: 35,
              color: Colors.blueAccent,
            ),
          ),
        ],
      );
    } else if (state is RecordingInProgress) {
      // In recording
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AvatarGlow(
            glowColor: Colors.blueAccent,
            child: IconButton.filled(
              onPressed: () {
                context.read<SpeakingBloc>().add(StopRecording());
              },
              icon: const Icon(
                Icons.mic_none_sharp,
                size: 35,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    } else if (state is RecordingStopped || state is PlaybackInProgress) {
      // Handle both RecordingStopped and PlaybackInProgress
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton.filled(
            onPressed: () {
              context.read<SpeakingBloc>().add(RecordingInitial());
            },
            icon: const Icon(
              Icons.cancel,
              size: 35,
              color: Colors.grey,
            ),
          ),
          if (state is RecordingStopped)
            IconButton.filled(
              onPressed: () async {
                final path = (state).path;
                if (await File(path).exists()) {
                  context.read<SpeakingBloc>().add(PlayRecording(path));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File not found')),
                  );
                }
              },
              icon: const Icon(
                Icons.play_arrow,
                size: 35,
                color: Colors.lightBlue,
              ),
            ),
          IconButton.filled(
            onPressed: () {
              final questionState = context.read<SpeakingQuestionBloc>().state;

              if (questionState is Speaking2QuestionSuccessState) {
                final question =
                    questionState.speakingGenerateTaskModel.first.question ??
                        "";
                final path = state is RecordingStopped
                    ? state.path
                    : (state as PlaybackInProgress).path;

                if (question.isNotEmpty && path.isNotEmpty) {
                  context.read<SpeakingBloc>().add(SpeakingCheckAudioEvent(
                        question: question,
                        audioPath: path,
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Question or audio path is missing')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Unable to send, question not found')),
                );
              }
            },
            icon: const Icon(
              Icons.send,
              size: 35,
              color: Colors.green,
            ),
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
