part of 'writing_bloc.dart';

sealed class WritingState extends Equatable {
  const WritingState();

  @override
  List<Object> get props => [];
}

final class WritingInitial extends WritingState {}

class Writing1GenerateTaskSuccessState extends WritingState {
  final List<Writing1GenerateTaskModel> writing1generateTaskModel;

  Writing1GenerateTaskSuccessState({required this.writing1generateTaskModel});
  @override
  List<Object> get props => [writing1generateTaskModel];
}

class Writing2GenerateTaskSuccessState extends WritingState {
  final List<Writing2GenerateModel> writing2generateTaskModel;

  Writing2GenerateTaskSuccessState({required this.writing2generateTaskModel});
  @override
  List<Object> get props => [writing2generateTaskModel];
}

class Writing1CheckGrammarSuccessState extends WritingState {
  final Writing1CheckGrammarModel writing1CheckGrammarModel;

  Writing1CheckGrammarSuccessState({required this.writing1CheckGrammarModel});
  @override
  List<Object> get props => [writing1CheckGrammarModel];
}

class Writing1EvaluateSuccessState extends WritingState {
  final Writing1EvaluateModel writing1evaluateModel;

  Writing1EvaluateSuccessState({required this.writing1evaluateModel});
  @override
  List<Object> get props => [writing1evaluateModel];
}

class Writing1OutPutSuccessState extends WritingState {
  final Writing1CheckGrammarModel writing1CheckGrammarModel;
  final Writing1EvaluateModel writing1evaluateModel;

  Writing1OutPutSuccessState(
      this.writing1CheckGrammarModel, this.writing1evaluateModel);
  @override
  List<Object> get props => [writing1CheckGrammarModel, writing1evaluateModel];
}

class Writing2OutPutSuccessState extends WritingState {
  final Writing1CheckGrammarModel writing2CheckGrammarModel;
  final Writing1EvaluateModel writing2evaluateModel;

  Writing2OutPutSuccessState(
      this.writing2CheckGrammarModel, this.writing2evaluateModel);
  @override
  List<Object> get props => [writing2CheckGrammarModel, writing2evaluateModel];
}

class WritingErrorState extends WritingState {
  final String message;

  WritingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
