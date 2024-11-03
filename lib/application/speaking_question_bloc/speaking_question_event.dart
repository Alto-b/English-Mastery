part of 'speaking_question_bloc.dart';

sealed class SpeakingQuestionEvent extends Equatable {
  const SpeakingQuestionEvent();

  @override
  List<Object> get props => [];
}

class Speaking2GenerateQuestionEvent extends SpeakingQuestionEvent {}
