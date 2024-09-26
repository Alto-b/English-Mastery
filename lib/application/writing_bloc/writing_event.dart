part of 'writing_bloc.dart';

sealed class WritingEvent extends Equatable {
  const WritingEvent();

  @override
  List<Object> get props => [];
}

class Writing1GenerateTaskEvent extends WritingEvent {}

class Writing1CheckGrammerEvent extends WritingEvent {
  String user_input;
  Writing1CheckGrammerEvent({
    required this.user_input,
  });
  @override
  List<Object> get props => [user_input];
}

class Writing1EvaluateEvent extends WritingEvent {
  String user_input;
  Writing1EvaluateEvent({
    required this.user_input,
  });
  @override
  List<Object> get props => [user_input];
}

class Writing1OutputEvent extends WritingEvent {
  String userInput;
  Writing1OutputEvent({
    required this.userInput,
  });
  @override
  List<Object> get props => [userInput];
}
