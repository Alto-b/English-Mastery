import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/writing1/writing1_check_model.dart';
import 'package:english_mastery/domain/writing1/writing1_evaluate_model.dart';
import 'package:english_mastery/domain/writing1/writing1_generate_model.dart';
import 'package:english_mastery/infrastructure/writing1_repo.dart';
import 'package:equatable/equatable.dart';

part 'writing_event.dart';
part 'writing_state.dart';

class WritingBloc extends Bloc<WritingEvent, WritingState> {
  final Writing1Repo writing1Repo;

  WritingBloc({required this.writing1Repo}) : super(WritingInitial()) {
    // Register the event handler for Writing1GenerateTaskEvent
    on<Writing1GenerateTaskEvent>(_writing1GenerateTaskMethod);
    // on<Writing1CheckGrammerEvent>(_writing1CheckGrammerMerthod);
    // on<Writing1EvaluateEvent>(_writing1EvaluateMethod);
    on<Writing1OutputEvent>(_writing1OutputMethod);
  }

  FutureOr<void> _writing1GenerateTaskMethod(
      Writing1GenerateTaskEvent event, Emitter<WritingState> emit) async {
    try {
      // Fetch the generated task from the repository
      final Writing1GenerateTaskModel? taskModel =
          await writing1Repo.writing1_generate_task();

      if (taskModel != null) {
        // Emit success state with the fetched task
        emit(Writing1GenerateTaskSuccessState(
          writing1generateTaskModel: [
            taskModel
          ], // Wrapping the model in a list
        ));
      } else {
        // Emit error state if the task model is null
        emit(WritingErrorState(message: 'Failed to generate writing task'));
      }
    } catch (error) {
      // Emit error state if an exception occurs
      emit(WritingErrorState(
          message: 'Failed to generate writing task ${error}'));
    }
  }

  FutureOr<void> _writing1CheckGrammerMerthod(
      Writing1CheckGrammerEvent event, Emitter<WritingState> emit) async {
    print("called_writing1CheckGrammerMerthod");
    try {
      // Fetch the generated task from the repository
      final Writing1CheckGrammarModel? taskModel =
          await writing1Repo.writing1_check_grammar(event.user_input);

      // if (taskModel != null) {
      emit(Writing1CheckGrammarSuccessState(
          writing1CheckGrammarModel: taskModel!));
      // } else {
      //   emit(WritingErrorState(message: 'Failed to evaluate the answer'));
      // }
    } catch (e) {
      emit(WritingErrorState(message: 'Failed to evaluate the answer: ${e}'));
    }
  }

  FutureOr<void> _writing1EvaluateMethod(
      Writing1EvaluateEvent event, Emitter<WritingState> emit) async {
    try {
      final Writing1EvaluateModel? taskModel =
          await writing1Repo.writing1_evaluation(event.user_input);
      if (taskModel != null) {
        emit(Writing1EvaluateSuccessState(writing1evaluateModel: taskModel));
      }
    } catch (e) {
      emit(WritingErrorState(message: 'Failed to evaluate the answer: ${e}'));
    }
  }

  FutureOr<void> _writing1OutputMethod(
      Writing1OutputEvent event, Emitter<WritingState> emit) async {
    try {
      final Writing1CheckGrammarModel? grammerModel =
          await writing1Repo.writing1_check_grammar(event.userInput);
      final Writing1EvaluateModel? EvaluateModel =
          await writing1Repo.writing1_evaluation(event.userInput);
      emit(Writing1OutPutSuccessState(grammerModel!, EvaluateModel!));
    } catch (e) {
      emit(WritingErrorState(message: 'Failed to evaluate the answer: ${e}'));
    }
  }
}
