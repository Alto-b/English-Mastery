import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlayBackWidget extends StatelessWidget {
  const PlayBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.abc),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<SpeakingBloc>().add(StartRecording());
                },
                child: Icon(Icons.restore),
              ),
              Gap(20),
              ElevatedButton(
                onPressed: () {
                  // context.read<SpeakingBloc>().add(StartRecording());
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
          Gap(20)
        ],
      ),
    );
  }
}
