part of 'vocabulary_bloc.dart';

sealed class VocabularyState extends Equatable {
  const VocabularyState();
  
  @override
  List<Object> get props => [];
}

final class VocabularyInitial extends VocabularyState {}
