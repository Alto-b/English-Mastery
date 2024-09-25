part of 'gemini_bloc.dart';

@immutable
sealed class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminiInitial extends GeminiState {}

class GeminiSuccessState extends GeminiState {
  final List<GeminiMessageModel> messages;

  const GeminiSuccessState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class GeminiErrorState extends GeminiState {
  final String errorMessage;

  const GeminiErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
