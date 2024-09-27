import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'speaking_event.dart';
part 'speaking_state.dart';

class SpeakingBloc extends Bloc<SpeakingEvent, SpeakingState> {
  final AudioRecorder _record;
  final AudioPlayer _audioPlayer = AudioPlayer();
  SpeakingBloc()
      : _record = AudioRecorder(),
        super(SpeakingInitial()) {
    on<StartRecording>(startRecordingMethod);
    on<StopRecording>(stopRecordingMethod);
    on<PauseRecording>(
        pauseRecordingMethod); // Added handler for PauseRecording
    on<ResumeRecording>(
        resumeRecordingMethod); // Added handler for ResumeRecording
    on<PlayRecording>(playRecordingMethod);
  }

  FutureOr<void> startRecordingMethod(
      StartRecording event, Emitter<SpeakingState> emit) async {
    if (await _record.hasPermission()) {
      try {
        // Get the application documents directory
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/myFile.m4a';

        // Start recording to file
        await _record.start(const RecordConfig(), path: filePath);
        emit(RecordingInProgress());
      } catch (e) {
        emit(RecordingError(e.toString()));
      }
    } else {
      emit(RecordingError("Permission denied"));
    }
  }

  FutureOr<void> stopRecordingMethod(
      StopRecording event, Emitter<SpeakingState> emit) async {
    try {
      final path = await _record.stop();
      emit(RecordingStopped(path!));
    } catch (e) {
      emit(RecordingError(e.toString()));
    }
  }

  FutureOr<void> pauseRecordingMethod(
      PauseRecording event, Emitter<SpeakingState> emit) async {
    try {
      await _record.pause();
      emit(RecordingPaused());
    } catch (e) {
      emit(RecordingError(e.toString()));
    }
  }

  FutureOr<void> resumeRecordingMethod(
      ResumeRecording event, Emitter<SpeakingState> emit) async {
    try {
      await _record.resume();
      emit(RecordingInProgress());
    } catch (e) {
      emit(RecordingError(e.toString()));
    }
  }

  FutureOr<void> playRecordingMethod(
      PlayRecording event, Emitter<SpeakingState> emit) async {
    try {
      await _audioPlayer.play(DeviceFileSource(event.filePath));
      emit(PlaybackInProgress());
    } catch (e) {
      emit(RecordingError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _record.dispose();
    return super.close();
  }
}
