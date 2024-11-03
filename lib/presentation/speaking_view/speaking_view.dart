// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/speaking_question_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

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
      body: Column(
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
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    height: screenHeight / 6,
                    width: double.infinity,
                    // color: Colors.amber,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: (state is SpeakingInitial) //initial state
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton.filled(
                                  onPressed: () {
                                    context
                                        .read<SpeakingBloc>()
                                        .add(StartRecording());
                                  },
                                  icon: const Icon(
                                    Icons.mic,
                                    size: 35,
                                    color: Colors.blueAccent,
                                  )),
                            ],
                          )
                        : (state is RecordingInProgress) //in recording
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AvatarGlow(
                                    glowColor: Colors.blueAccent,
                                    child: IconButton.filled(
                                        onPressed: () {
                                          context
                                              .read<SpeakingBloc>()
                                              .add(StopRecording());
                                        },
                                        icon: const Icon(
                                          Icons.mic_none_sharp,
                                          size: 35,
                                          color: Colors.blueAccent,
                                        )),
                                  ),
                                ],
                              )
                            : (state is RecordingStopped) //recording stopped
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton.filled(
                                          onPressed: () {
                                            context
                                                .read<SpeakingBloc>()
                                                .add(RecordingInitial());
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 35,
                                            color: Colors.grey,
                                          )),
                                      IconButton.filled(
                                          onPressed: () async {
                                            final path = (state).path;
                                            if (await File(path).exists()) {
                                              context
                                                  .read<SpeakingBloc>()
                                                  .add(PlayRecording(path));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text('File not found')),
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            size: 35,
                                            color: Colors.lightBlue,
                                          )),
                                    ],
                                  )
                                : (state
                                        is PlaybackInProgress) //audio in playback
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton.filled(
                                              onPressed: () {
                                                context
                                                    .read<SpeakingBloc>()
                                                    .add(RecordingInitial());
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                size: 35,
                                                color: Colors.blueAccent,
                                              )),
                                          Lottie.asset(
                                              'assets/loader/sound_wave.json'),
                                          IconButton.filled(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.send,
                                                size: 35,
                                                color: Colors.green,
                                              )),
                                        ],
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
          ),
          Gap(screenHeight / 18)
        ],
      ),
    );
  }
}
