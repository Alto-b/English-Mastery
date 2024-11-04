part of 'speaking_bloc.dart';

// Sealed class to represent all possible states
sealed class SpeakingState extends Equatable {
  const SpeakingState();

  @override
  List<Object> get props => [];
}

final class SpeakingInitial extends SpeakingState {}

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

class PlaybackInProgress extends SpeakingState {}
