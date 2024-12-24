part of 'speaking_bloc.dart';

// Sealed class to represent all possible states
abstract class SpeakingState extends Equatable {
  const SpeakingState();

  @override
  List<Object> get props => [];
}

final class SpeakingInitial extends SpeakingState {}

final class SpeakingErrorState extends SpeakingState {}

class RecordingInProgress extends SpeakingState {}

class RecordingPaused extends SpeakingState {}

class RecordingStopped extends SpeakingState {
  final String path;

  const RecordingStopped(this.path);

  @override
  List<Object> get props => [path];
}

class RecordingError extends SpeakingState {
  final String error;

  const RecordingError(this.error);

  @override
  List<Object> get props => [error];
}

class PlaybackInProgress extends SpeakingState {
  final String path;

  const PlaybackInProgress(this.path);

  @override
  List<Object> get props => [path];
}

class CheckAudioInProgressState extends SpeakingState {}

class CheckAudioSuccessState extends SpeakingState {
  final List<Speaking2CheckAudioResponseModel?> taskModel;
  final String feedbackAudioPath; // Added file path

  const CheckAudioSuccessState(this.taskModel, this.feedbackAudioPath);

  @override
  List<Object> get props => [taskModel, feedbackAudioPath]; // Updated props
}

class CheckAudioFailureState extends SpeakingState {
  final String error;

  const CheckAudioFailureState(this.error);
}
