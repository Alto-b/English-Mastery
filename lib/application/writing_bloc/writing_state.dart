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

class WritingErrorState extends WritingState {
  final String message;

  WritingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
