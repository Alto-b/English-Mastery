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

  GrammarErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class GrammarPastTimeState extends GrammarState {
  final List<PastTimeModel> pastTimeModel;

  GrammarPastTimeState({required this.pastTimeModel});
  @override
  List<Object> get props => [pastTimeModel];
}
