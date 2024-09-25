part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

class ChatGenerateNewTextMessageEvent extends GeminiEvent {
  final String inputMessage;

  const ChatGenerateNewTextMessageEvent({required this.inputMessage});

  @override
  List<Object> get props => [inputMessage];
}
