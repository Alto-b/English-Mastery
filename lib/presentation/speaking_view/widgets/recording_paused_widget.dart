import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordingPausedWidget extends StatelessWidget {
  const RecordingPausedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<SpeakingBloc>().add(ResumeRecording());
        },
        child: Text('Resume Recording'),
      ),
    );
  }
}
