part of 'speaking_bloc.dart';

// Ensure this is an abstract class, meant to be extended by specific events.
abstract class SpeakingEvent extends Equatable {
  const SpeakingEvent();

  @override
  List<Object> get props => [];
}

class RecordingInitial extends SpeakingEvent {}

class StartRecording extends SpeakingEvent {}

class StopRecording extends SpeakingEvent {}

class PauseRecording extends SpeakingEvent {}

class ResumeRecording extends SpeakingEvent {}

class PlayRecording extends SpeakingEvent {
  final String filePath;

  const PlayRecording(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class GenerateSpeakingQuestion extends SpeakingEvent {
  final String question;

  const GenerateSpeakingQuestion({required this.question});
  @override
  List<Object> get props => [question];
}

class SpeakingCheckAudioEvent extends SpeakingEvent {
  final String question;
  final String audioPath;
  const SpeakingCheckAudioEvent({
    required this.question,
    required this.audioPath,
  });
  @override
  List<Object> get props => [question, audioPath];
}
