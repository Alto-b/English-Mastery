part of 'grammar_bloc.dart';

sealed class GrammarEvent extends Equatable {
  const GrammarEvent();

  @override
  List<Object> get props => [];
}

class GrammarPastTimeEvent extends GrammarEvent {}

class GrammarFutureTimeEvent extends GrammarEvent {}

class GrammarArticlesQuantifiersEvent extends GrammarEvent {}

class GrammarComparitivesSuperlativesEvent extends GrammarEvent {}

class GrammarModalsEvent extends GrammarEvent {}

class GrammarPassiveCausative extends GrammarEvent {}
