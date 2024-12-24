import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/speaking/speaking_check_audio_response_model.dart';
import 'package:english_mastery/domain/speaking/speaking_generate_model.dart';
import 'package:english_mastery/infrastructure/speaking_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    on<SpeakingCheckAudioEvent>(checkSpeakingAudioMethod);
  }

  FutureOr<void> startRecordingMethod(
      StartRecording event, Emitter<SpeakingState> emit) async {
    if (await _record.hasPermission()) {
      try {
        // Get the application documents directory
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${DateTime.now().second}myFile.wav';

        // Start recording to file in MP3 format
        await _record.start(
            const RecordConfig(
              encoder: AudioEncoder.wav,
            ),
            path: filePath);

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
      emit(PlaybackInProgress(event.filePath)); // Pass the path to the state
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

  FutureOr<void> checkSpeakingAudioMethod(
      SpeakingCheckAudioEvent event, Emitter<SpeakingState> emit) async {
    try {
      emit(CheckAudioInProgressState());

      final Speaking2CheckAudioResponseModel? checkAudioResult =
          await speakingRepo.uploadAudioWithHttp(
              event.audioPath, event.question);

      String? feedbackAudioPath;

      if (checkAudioResult != null) {
        // final correctedText = checkAudioResult.correctedText;
        final generalFeedback = checkAudioResult.generalFeedback;
        if (generalFeedback != null && generalFeedback.isNotEmpty) {
          await speakingRepo.generateFeedbackAudio(generalFeedback);
          final directory = await getApplicationDocumentsDirectory();
          feedbackAudioPath = '${directory.path}/generated_audio.mp3';

          // Verify if the file exists
          final file = File(feedbackAudioPath);
          if (!file.existsSync()) {
            throw Exception(
                "Feedback audio file not found at $feedbackAudioPath");
          }
          print("Feedback audio generated and saved at: $feedbackAudioPath");
        }

        emit(CheckAudioSuccessState([checkAudioResult], feedbackAudioPath!));
      } else {
        emit(const CheckAudioFailureState("Failed to upload and check audio."));
      }
    } catch (e, stackTrace) {
      emit(CheckAudioFailureState(e.toString()));
      debugPrint("Error in checkSpeakingAudioMethod: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }
}
