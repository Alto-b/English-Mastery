part of 'speaking_question_bloc.dart';

sealed class SpeakingQuestionState extends Equatable {
  const SpeakingQuestionState();

  @override
  List<Object> get props => [];
}

final class SpeakingQuestionInitial extends SpeakingQuestionState {}

class Speaking2QuestionSuccessState extends SpeakingQuestionState {
  final List<SpeakingGenerateTaskModel> speakingGenerateTaskModel;

  Speaking2QuestionSuccessState({required this.speakingGenerateTaskModel});
  @override
  List<Object> get props => [speakingGenerateTaskModel];
}

class Speaking2QuestionErrorState extends SpeakingQuestionState {
  final String message;

  Speaking2QuestionErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
