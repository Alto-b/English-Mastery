import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/vocabulary/sentence_completion_model.dart';
import 'package:english_mastery/infrastructure/vocabulary_repo.dart';
import 'package:equatable/equatable.dart';

part 'vocabulary_event.dart';
part 'vocabulary_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  final VocabularyRepo vocabulary_repo;
  VocabularyBloc(this.vocabulary_repo) : super(VocabularyInitial()) {
    on<VocabularyEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<VocabualarySentenceCompletionEvent>(generateSentenceCompletion);
  }

  FutureOr<void> generateSentenceCompletion(
      VocabualarySentenceCompletionEvent event,
      Emitter<VocabularyState> emit) async {
    try {
      final VocabularySentenceCompletionModel? taskModel =
          await vocabulary_repo.generate_sentence_completion();
      if (taskModel != null) {
        emit(VocabularySentenceCompletionState(
            sentenceCompletionModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }
}
