part of 'speaking_bloc.dart';

// Ensure this is an abstract class, meant to be extended by specific events.
class SpeakingEvent extends Equatable {
  const SpeakingEvent();

  @override
  List<Object> get props => [];
}

// Specific event subclasses
class StartRecording extends SpeakingEvent {}

class StopRecording extends SpeakingEvent {}

class PauseRecording extends SpeakingEvent {}

class ResumeRecording extends SpeakingEvent {}

class PlayRecording extends SpeakingEvent {
  final String filePath;

  PlayRecording(this.filePath);

  @override
  List<Object> get props => [filePath];
}
