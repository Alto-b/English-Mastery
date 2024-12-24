part of 'vocabulary_bloc.dart';

sealed class VocabularyState extends Equatable {
  const VocabularyState();

  @override
  List<Object> get props => [];
}

final class VocabularyInitial extends VocabularyState {}

class VocabularyLoadingState extends VocabularyState {}

class VocabularyErrorState extends VocabularyState {
  final String errorMessage;

  const VocabularyErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class VocabularySentenceCompletionState extends VocabularyState {
  final List<VocabularySentenceCompletionModel> sentenceCompletionModel;

  const VocabularySentenceCompletionState(
      {required this.sentenceCompletionModel});
  @override
  List<Object> get props => [sentenceCompletionModel];
}

class VocabularyErrorCorrectionState extends VocabularyState {
  final List<ErrorCorrectionModel> errorCorrectionModel;

  const VocabularyErrorCorrectionState({required this.errorCorrectionModel});
  @override
  List<Object> get props => [errorCorrectionModel];
}

class VocabularyMultipleChoicState extends VocabularyState {
  final List<MultipleChoiceModel> multipleChoiceModel;

  const VocabularyMultipleChoicState({required this.multipleChoiceModel});
  @override
  List<Object> get props => [multipleChoiceModel];
}

class VocabularySynonymsAntonymsState extends VocabularyState {
  final List<SynonymsAntonymsModel> synonymsAntonymsModel;

  const VocabularySynonymsAntonymsState({required this.synonymsAntonymsModel});
  @override
  List<Object> get props => [synonymsAntonymsModel];
}

class VocabularyCollocationState extends VocabularyState {
  final List<CollocationModel> collocationModel;

  const VocabularyCollocationState({required this.collocationModel});
  @override
  List<Object> get props => [collocationModel];
}

class VocabularyWordFormsState extends VocabularyState {
  final List<WordFormsModel> wordFormsModel;

  const VocabularyWordFormsState({required this.wordFormsModel});
  @override
  List<Object> get props => [wordFormsModel];
}

class VocabularyContextCluesState extends VocabularyState {
  final List<ContextCluesModel> contextCluesModel;

  const VocabularyContextCluesState({required this.contextCluesModel});
  @override
  List<Object> get props => [contextCluesModel];
}

class VocabularyIdiomPhrasesState extends VocabularyState {
  final List<IdiomPhrasesModel> idiomPhrasesModel;

  const VocabularyIdiomPhrasesState({required this.idiomPhrasesModel});
  @override
  List<Object> get props => [idiomPhrasesModel];
}

class VocabularyPhrasalVerbsState extends VocabularyState {
  final List<PhrasalVerbsModel> phrasalVerbsModel;

  const VocabularyPhrasalVerbsState({required this.phrasalVerbsModel});
  @override
  List<Object> get props => [phrasalVerbsModel];
}
