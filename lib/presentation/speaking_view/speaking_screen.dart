import 'dart:io';

import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeakingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeakingBloc(),
      child: RecordingView(),
    );
  }
}

class RecordingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recording Example')),
      body: BlocBuilder<SpeakingBloc, SpeakingState>(
        builder: (context, state) {
          if (state is SpeakingInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SpeakingBloc>().add(StartRecording());
                },
                child: Text('Start Recording'),
              ),
            );
          } else if (state is RecordingInProgress) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SpeakingBloc>().add(StopRecording());
                },
                child: Text('Stop Recording'),
              ),
            );
          } else if (state is RecordingPaused) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SpeakingBloc>().add(ResumeRecording());
                },
                child: Text('Resume Recording'),
              ),
            );
          } else if (state is RecordingStopped) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<SpeakingBloc>().add(StartRecording());
                    },
                    child: Text('Start New Recording'),
                  ),
                  SizedBox(height: 20),
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
                    child: Text('Play Recording'),
                  ),
                ],
              ),
            );
          } else if (state is RecordingError) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
