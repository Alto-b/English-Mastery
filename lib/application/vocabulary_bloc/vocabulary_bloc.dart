import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/vocabulary/error_correction_model.dart';
import 'package:english_mastery/domain/vocabulary/multiple_choice_model.dart';
import 'package:english_mastery/domain/vocabulary/sentence_completion_model.dart';
import 'package:english_mastery/domain/vocabulary/synonyms_antonyms_model.dart';
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
    on<VocabualaryErrorCorrectionEvent>(generateErrorCorrection);
    on<VocabularyMultipleChoiceEvent>(generateMultipleChoice);
    on<VocabularySynonymsAntonymsEvent>(generateSynonymsAntonyms);
  }

  FutureOr<void> generateSentenceCompletion(
      VocabualarySentenceCompletionEvent event,
      Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
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

  FutureOr<void> generateErrorCorrection(VocabualaryErrorCorrectionEvent event,
      Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final ErrorCorrectionModel? taskModel =
          await vocabulary_repo.generate_error_correction();
      if (taskModel != null) {
        emit(VocabularyErrorCorrectionState(errorCorrectionModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generateMultipleChoice(VocabularyMultipleChoiceEvent event,
      Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final MultipleChoiceModel? taskModel =
          await vocabulary_repo.generate_multiple_choice();
      if (taskModel != null) {
        emit(VocabularyMultipleChoicState(multipleChoiceModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generateSynonymsAntonyms(VocabularySynonymsAntonymsEvent event,
      Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final SynonymsAntonymsModel? taskModel =
          await vocabulary_repo.generate_synonyms_antonyms();
      if (taskModel != null) {
        emit(VocabularySynonymsAntonymsState(
            synonymsAntonymsModel: [taskModel]));
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
