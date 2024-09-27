import 'dart:io';

import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/playback_widget.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/recording_error_widget.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/recording_initial_widget.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/recording_inprogress_widget.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/recording_paused_widget.dart';
import 'package:english_mastery/presentation/speaking_view/widgets/recording_stopped_widget.dart';
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
      appBar: AppBar(title: const Text('Speaking')),
      body: BlocBuilder<SpeakingBloc, SpeakingState>(
        builder: (context, state) {
          if (state is SpeakingInitial) {
            return const RecordingInitialWidget();
          } else if (state is RecordingInProgress) {
            return const RecordingInProgressWidget();
          } else if (state is RecordingPaused) {
            return const RecordingPausedWidget();
          } else if (state is RecordingStopped) {
            return RecordingStoppedWidget(
              state: state,
            );
          } else if (state is RecordingError) {
            return RecordingErrorWidget(
              state: state,
            );
          } else if (state is PlaybackInProgress) {
            return PlayBackWidget();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
