import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/gemini_model.dart';
import 'package:english_mastery/infrastructure/gemini_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc({required GeminiRepo geminiRepo}) : super(GeminiInitial()) {
    on<ChatGenerateNewTextMessageEvent>(_chatGenerateNewTextMessageEvent);
  }

  List<GeminiMessageModel> messages = [];
  bool generating = false;

  Future<void> _chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<GeminiState> emit) async {
    messages.add(GeminiMessageModel(
        role: "user", parts: [GeminiPartModel(text: event.inputMessage)]));
    emit(GeminiSuccessState(messages: List.from(messages)));
    generating = true;

    try {
      final generatedText = await GeminiRepo.geminiTextGenerationRepo(messages);

      if (generatedText.isNotEmpty) {
        final parsedText = _parseText(generatedText);
        messages.add(GeminiMessageModel(
            role: 'model', parts: [GeminiPartModel(text: parsedText)]));
        emit(GeminiSuccessState(messages: List.from(messages)));
      } else {
        emit(GeminiErrorState(errorMessage: 'Failed to generate a response.'));
      }
    } catch (e) {
      emit(GeminiErrorState(errorMessage: e.toString()));
    } finally {
      generating = false;
    }
  }

  String _parseText(String text) {
    // Combined method to remove both formatting characters.
    return text.replaceAll("'''", '').replaceAll("*", '');
  }
}
