import 'package:audioplayers/audioplayers.dart';
import 'package:english_mastery/presentation/home_view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';

class SpeakingResultView extends StatelessWidget {
  const SpeakingResultView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to homepage on back button press
        Get.offAll(() => const HomeScreen());
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Speaking Result"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate to homepage on AppBar back button press
              Get.offAll(() => const HomeScreen());
            },
          ),
        ),
        body: BlocBuilder<SpeakingBloc, SpeakingState>(
          builder: (context, state) {
            if (state is CheckAudioSuccessState) {
              final taskModels = state.taskModel;

              if (taskModels.isEmpty || taskModels[0] == null) {
                return const Center(
                  child: Text(
                    "No results available.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    ...taskModels.map((model) {
                      if (model == null) return const SizedBox.shrink();

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Center(
                                child: Text(
                                  (model.status!)
                                      ? ""
                                      : "The recorded audio does not match the question",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: (model.status!)
                                          ? Colors.greenAccent
                                          : Colors.redAccent),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text(
                                    "General Feedback:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: state.feedbackAudioPath.isNotEmpty
                                        ? () {
                                            final player = AudioPlayer();
                                            player.play(DeviceFileSource(
                                                state.feedbackAudioPath));
                                          }
                                        : null, // Disable the button if the path is null or empty
                                    icon: const Icon(Icons.play_arrow),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.generalFeedback ??
                                    "No general feedback available",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Match Feedback:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.matchFeedback ??
                                    "No match feedback available",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Corrected Text:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.correctedText ??
                                    "No corrected text available",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            } else if (state is CheckAudioFailureState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 50, color: Colors.red),
                    const SizedBox(height: 20),
                    Text(
                      "Error: ${state.error}",
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
    );
  }
}
