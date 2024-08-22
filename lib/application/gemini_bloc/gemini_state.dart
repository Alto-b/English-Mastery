part of 'gemini_bloc.dart';

@immutable
sealed class GeminiState {}

final class GeminiInitial extends GeminiState {}

class GeminiSuccessState extends GeminiState {
  final List<GeminiMessageModel> messages;
  GeminiSuccessState({
    required this.messages,
  });
}
