import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/reading/reading1_model.dart';
import 'package:english_mastery/infrastructure/reading_repo.dart';
import 'package:english_mastery/presentation/reading_view/reading1/reading_result_view.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'reading_event.dart';
part 'reading_state.dart';

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  final Reading1Repo reading1Repo;
  ReadingBloc(this.reading1Repo) : super(ReadingInitial()) {
    on<ReadingEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<loadReadingEvent>(generateReadingEvent);
    on<calculateReadingScoreEvent>(generateReadingScore);
  }

  FutureOr<void> generateReadingEvent(
      loadReadingEvent event, Emitter<ReadingState> emit) async {
    emit(ReadingLoadingState());
    try {
      final Reading1Model? taskModel =
          await reading1Repo.generate_reading1_repo();
      if (taskModel != null && taskModel.status == "success") {
        emit(ReadingLoadingSuccessState(reading1TaskModel: [taskModel]));
      } else if (taskModel != null &&
          (taskModel.status == null || taskModel.status != "success")) {
        emit(Reading422State(errorMessage: "Couldn't load the task"));
      } else {
        emit(Reading1ErrorState(errorMessage: "Failed to load reading task."));
      }
    } catch (e) {
      emit(Reading1ErrorState(errorMessage: "Failed to load reading task. $e"));
    }
  }

  FutureOr<void> generateReadingScore(
      calculateReadingScoreEvent event, Emitter<ReadingState> emit) async {
    emit(CalculatingReadingScoreState());

    try {
      // Use correct answers directly
      List<String> correctTrueFalseAnswers = event.correctTrueFalseAnswers;
      List<String> correctMultipleChoiceAnswers =
          event.correctMultipleChoiceAnswers;
      List<String> correctCompleteTheSentenceAnswers =
          event.correctCompleteTheSentenceAnswers;

      // User-provided answers from the event
      List<String?> userTrueFalseAnswers = event.userTrueFalseAnswers;
      List<String?> userMultipleChoiceAnswers = event.userMultipleChoiceAnswers;
      List<String?> userCompleteTheSentenceAnswers =
          event.userCompleteTheSentenceAnswers;

      // Initialize score counters
      int trueFalseScore = 0;
      int multipleChoiceScore = 0;
      int completeTheSentenceScore = 0;

      // Calculate True/False score
      for (int i = 0; i < correctTrueFalseAnswers.length; i++) {
        if (userTrueFalseAnswers[i]?.toLowerCase() ==
            correctTrueFalseAnswers[i].toLowerCase()) {
          trueFalseScore++;
        }
      }

      // Calculate Multiple Choice score
      for (int i = 0; i < correctMultipleChoiceAnswers.length; i++) {
        if (userMultipleChoiceAnswers[i] == correctMultipleChoiceAnswers[i]) {
          multipleChoiceScore++;
        }
      }

      // Calculate Complete the Sentence score
      for (int i = 0; i < correctCompleteTheSentenceAnswers.length; i++) {
        if (userCompleteTheSentenceAnswers[i] ==
            correctCompleteTheSentenceAnswers[i]) {
          completeTheSentenceScore++;
        }
      }

      // Calculate percentage scores
      int trueFalsePercentage =
          ((trueFalseScore / correctTrueFalseAnswers.length) * 100).round();
      int multipleChoicePercentage =
          ((multipleChoiceScore / correctMultipleChoiceAnswers.length) * 100)
              .round();
      int completeTheSentencePercentage = ((completeTheSentenceScore /
                  correctCompleteTheSentenceAnswers.length) *
              100)
          .round();

      // Emit the final percentage scores
      emit(ReadingScoreGenerated(
        trueFalseScore: trueFalsePercentage,
        multipleChoiceScore: multipleChoicePercentage,
        completeTheSentenceScore: completeTheSentencePercentage,
      ));

      print(
          "Final Scores -> True/False: $trueFalsePercentage%, Multiple Choice: $multipleChoicePercentage%, Complete the Sentence: $completeTheSentencePercentage%");
    } catch (e) {
      print("Error calculating score: $e");
      emit(Reading1ErrorState(errorMessage: "Error calculating score: $e"));
    }
  }
}
