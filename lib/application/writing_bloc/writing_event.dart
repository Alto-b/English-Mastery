part of 'writing_bloc.dart';

sealed class WritingEvent extends Equatable {
  const WritingEvent();

  @override
  List<Object> get props => [];
}

class Writing1GenerateTaskEvent extends WritingEvent {}
