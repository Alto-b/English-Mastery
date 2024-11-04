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
