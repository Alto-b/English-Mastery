import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/writing1_task_model.dart';
import 'package:english_mastery/infrastructure/writing1_repo.dart';
import 'package:equatable/equatable.dart';

part 'writing_event.dart';
part 'writing_state.dart';

class WritingBloc extends Bloc<WritingEvent, WritingState> {
  final Writing1Repo writing1Repo;

  WritingBloc({required this.writing1Repo}) : super(WritingInitial()) {
    // Register the event handler for Writing1GenerateTaskEvent
    on<Writing1GenerateTaskEvent>(_writing1GenerateTaskMethod);
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
}
