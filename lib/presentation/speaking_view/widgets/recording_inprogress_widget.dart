import 'package:avatar_glow/avatar_glow.dart';
import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RecordingInProgressWidget extends StatelessWidget {
  const RecordingInProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("data"),
            Spacer(),
            Column(
              children: [
                ElevatedButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: () {
                    context.read<SpeakingBloc>().add(StopRecording());
                  },
                  child: AvatarGlow(
                      glowShape: BoxShape.circle,
                      glowColor: Colors.white,
                      glowCount: 8,
                      child: Icon(Icons.mic_outlined)),
                ),
                Text(
                  'Stop Recording',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Gap(20)
          ],
        ),
      ),
    );
  }
}
