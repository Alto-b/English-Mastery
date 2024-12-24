part of 'reading_bloc.dart';

sealed class ReadingState extends Equatable {
  const ReadingState();

  @override
  List<Object> get props => [];
}

final class ReadingInitial extends ReadingState {}

class ReadingLoadingState extends ReadingState {}

class ReadingLoadingSuccessState extends ReadingState {
  final List<Reading1Model> reading1TaskModel;

  const ReadingLoadingSuccessState({required this.reading1TaskModel});
  @override
  List<Object> get props => [reading1TaskModel];
}

class Reading422State extends ReadingState {
  final String errorMessage;

  const Reading422State({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class Reading1ErrorState extends ReadingState {
  final String errorMessage;

  const Reading1ErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CalculatingReadingScoreState extends ReadingState {}

class ReadingScoreGenerated extends ReadingState {
  final int trueFalseScore;
  final int multipleChoiceScore;
  final int completeTheSentenceScore;

  const ReadingScoreGenerated(
      {required this.trueFalseScore,
      required this.multipleChoiceScore,
      required this.completeTheSentenceScore});
  @override
  List<Object> get props => [
        trueFalseScore,
        multipleChoiceScore,
        completeTheSentenceScore,
      ];
}
