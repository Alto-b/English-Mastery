part of 'grammar_bloc.dart';

sealed class GrammarState extends Equatable {
  const GrammarState();

  @override
  List<Object> get props => [];
}

final class GrammarInitial extends GrammarState {}

class GrammarLoadingState extends GrammarState {}

class GrammarErrorState extends GrammarState {
  final String errorMessage;

  const GrammarErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class GrammarPastTimeState extends GrammarState {
  final List<PastTimeModel> pastTimeModel;

  const GrammarPastTimeState({required this.pastTimeModel});
  @override
  List<Object> get props => [pastTimeModel];
}

class GrammarFutureTimeState extends GrammarState {
  final List<FutureTimeModel> futureTimeModel;

  const GrammarFutureTimeState({required this.futureTimeModel});
  @override
  List<Object> get props => [futureTimeModel];
}

class GrammarArticlesQuantifiersState extends GrammarState {
  final List<ArticlesQuantifiersModel> articlesQuantifiersModel;

  const GrammarArticlesQuantifiersState({required this.articlesQuantifiersModel});
  @override
  List<Object> get props => [articlesQuantifiersModel];
}

class GrammarComparitivesSuperlativesState extends GrammarState {
  final List<ComparativesSuperlativesModel> comparitivesSuperlativesModel;

  const GrammarComparitivesSuperlativesState(
      {required this.comparitivesSuperlativesModel});
  @override
  List<Object> get props => [comparitivesSuperlativesModel];
}

class GrammarModalsState extends GrammarState {
  final List<ModalsModel> modalsModel;

  const GrammarModalsState({required this.modalsModel});
  @override
  List<Object> get props => [modalsModel];
}

class GrammarPassiveCausativeState extends GrammarState {
  final List<PassiveCausativeModel> passiveCausativeModel;

  const GrammarPassiveCausativeState({required this.passiveCausativeModel});
  @override
  List<Object> get props => [passiveCausativeModel];
}
