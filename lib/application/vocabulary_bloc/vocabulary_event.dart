part of 'vocabulary_bloc.dart';

sealed class VocabularyEvent extends Equatable {
  const VocabularyEvent();

  @override
  List<Object> get props => [];
}

class VocabualarySentenceCompletionEvent extends VocabularyEvent {}

class VocabualaryErrorCorrectionEvent extends VocabularyEvent {}

class VocabularyMultipleChoiceEvent extends VocabularyEvent {}

class VocabularySynonymsAntonymsEvent extends VocabularyEvent {}

class VocabularyCollocationEvent extends VocabularyEvent {}

class VocabularyWordFormEvent extends VocabularyEvent {}

class VocabularyContextCluesEvent extends VocabularyEvent {}

class VocabularyIdiomPhrasesEvent extends VocabularyEvent {}

class VocabularyPhrasalVerbsEvent extends VocabularyEvent {}
