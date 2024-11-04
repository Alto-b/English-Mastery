import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/speaking/speaking_generate_model.dart';
import 'package:english_mastery/infrastructure/speaking_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

part 'speaking_event.dart';
part 'speaking_state.dart';

class SpeakingBloc extends Bloc<SpeakingEvent, SpeakingState> {
  final SpeakingRepo speakingRepo;
  final AudioRecorder _record;
  final AudioPlayer _audioPlayer = AudioPlayer();
  SpeakingBloc(this.speakingRepo)
      : _record = AudioRecorder(),
        super(SpeakingInitial()) {
    on<RecordingInitial>(initPlayer);
    on<StartRecording>(startRecordingMethod);
    on<StopRecording>(stopRecordingMethod);
    on<PauseRecording>(
        pauseRecordingMethod); // Added handler for PauseRecording
    on<ResumeRecording>(
        resumeRecordingMethod); // Added handler for ResumeRecording
    on<PlayRecording>(playRecordingMethod);
    on<GenerateSpeakingQuestion>(generateSpeakingQuestion);
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
      emit(const RecordingError("Permission denied"));
    }
  }

  FutureOr<void> stopRecordingMethod(
      StopRecording event, Emitter<SpeakingState> emit) async {
    try {
      final path = await _record.stop();
      emit(RecordingStopped(path!));
      print("recorded file : ${path.length}");
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

  FutureOr<void> generateSpeakingQuestion(
      GenerateSpeakingQuestion event, Emitter<SpeakingState> emit) async {
    try {
      final SpeakingGenerateTaskModel? taskModel =
          await speakingRepo.speaking_generate_task();
      if (taskModel != null) {
        // emit(Spea);
      }
    } catch (e) {}
  }

  FutureOr<void> initPlayer(
      RecordingInitial event, Emitter<SpeakingState> emit) {
    emit(SpeakingInitial());
  }
}
