import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/vocabulary/collocation_model.dart';
import 'package:english_mastery/domain/vocabulary/context_clues_model.dart';
import 'package:english_mastery/domain/vocabulary/error_correction_model.dart';
import 'package:english_mastery/domain/vocabulary/idioms_phrases_model.dart';
import 'package:english_mastery/domain/vocabulary/multiple_choice_model.dart';
import 'package:english_mastery/domain/vocabulary/phrasal_verbs_model.dart';
import 'package:english_mastery/domain/vocabulary/sentence_completion_model.dart';
import 'package:english_mastery/domain/vocabulary/synonyms_antonyms_model.dart';
import 'package:english_mastery/domain/vocabulary/word_forms_model.dart';
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
    on<VocabularyCollocationEvent>(generateCollocations);
    on<VocabularyWordFormEvent>(generateWordForms);
    on<VocabularyContextCluesEvent>(generateContextClues);
    on<VocabularyIdiomPhrasesEvent>(generateIdiomPhrases);
    on<VocabularyPhrasalVerbsEvent>(generatePhrasalVerbs);
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

  FutureOr<void> generateCollocations(
      VocabularyCollocationEvent event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final CollocationModel? taskModel =
          await vocabulary_repo.generate_collocations();
      if (taskModel != null) {
        emit(VocabularyCollocationState(collocationModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generateWordForms(
      VocabularyWordFormEvent event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final WordFormsModel? taskModel =
          await vocabulary_repo.generate_word_forms();
      if (taskModel != null) {
        emit(VocabularyWordFormsState(wordFormsModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generateContextClues(
      VocabularyContextCluesEvent event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final ContextCluesModel? taskModel =
          await vocabulary_repo.generate_context_clues();
      if (taskModel != null) {
        emit(VocabularyContextCluesState(contextCluesModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generateIdiomPhrases(
      VocabularyIdiomPhrasesEvent event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final IdiomPhrasesModel? taskModel =
          await vocabulary_repo.generate_idiom_phrases();
      if (taskModel != null) {
        emit(VocabularyIdiomPhrasesState(idiomPhrasesModel: [taskModel]));
      } else {
        emit(const VocabularyErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(VocabularyErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generatePhrasalVerbs(
      VocabularyPhrasalVerbsEvent event, Emitter<VocabularyState> emit) async {
    emit(VocabularyLoadingState());
    try {
      final PhrasalVerbsModel? taskModel =
          await vocabulary_repo.generate_phrasal_verbs();
      if (taskModel != null) {
        emit(VocabularyPhrasalVerbsState(phrasalVerbsModel: [taskModel]));
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
