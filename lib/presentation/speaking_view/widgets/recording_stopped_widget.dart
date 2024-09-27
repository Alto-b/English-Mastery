import 'dart:io';

import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RecordingStoppedWidget extends StatelessWidget {
  RecordingStoppedWidget({
    super.key,
    required this.state,
  });
  final RecordingStopped state;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SpeakingBloc>().add(StartRecording());
                  },
                  child: Icon(Icons.restore_sharp),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () async {
                    final path = (state as RecordingStopped).path;
                    if (await File(path).exists()) {
                      context.read<SpeakingBloc>().add(PlayRecording(path));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('File not found')),
                      );
                    }
                  },
                  child: Icon(Icons.play_arrow),
                ),
              ],
            ),
            Gap(20)
          ],
        ),
      ),
    );
  }
}
