part of 'reading_bloc.dart';

sealed class ReadingEvent extends Equatable {
  const ReadingEvent();

  @override
  List<Object> get props => [];
}

class loadReadingEvent extends ReadingEvent {}

// class calculateReadingScoreEvent extends ReadingEvent {
//   late List<bool?> truefalseanswers;
//   late List<String?> multipleChoiceAnswers;
//   late List<String?> completethesentenceanswers;
//   @override
//   List<Object> get props =>
//       [truefalseanswers, multipleChoiceAnswers, completethesentenceanswers];
// }
class calculateReadingScoreEvent extends ReadingEvent {
  final List<String?> userTrueFalseAnswers;
  final List<String?> userMultipleChoiceAnswers;
  final List<String?> userCompleteTheSentenceAnswers;
  final List<String> correctTrueFalseAnswers;
  final List<String> correctMultipleChoiceAnswers;
  final List<String> correctCompleteTheSentenceAnswers;

  const calculateReadingScoreEvent({
    required this.userTrueFalseAnswers,
    required this.userMultipleChoiceAnswers,
    required this.userCompleteTheSentenceAnswers,
    required this.correctTrueFalseAnswers,
    required this.correctMultipleChoiceAnswers,
    required this.correctCompleteTheSentenceAnswers,
  });

  @override
  List<Object> get props => [
        userTrueFalseAnswers,
        userMultipleChoiceAnswers,
        userCompleteTheSentenceAnswers,
        correctTrueFalseAnswers,
        correctMultipleChoiceAnswers,
        correctCompleteTheSentenceAnswers,
      ];
}
