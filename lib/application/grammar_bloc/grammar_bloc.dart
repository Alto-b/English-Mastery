import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/grammar/past_time_model.dart';
import 'package:english_mastery/infrastructure/grammar_repo.dart';
import 'package:equatable/equatable.dart';

part 'grammar_event.dart';
part 'grammar_state.dart';

class GrammarBloc extends Bloc<GrammarEvent, GrammarState> {
  final GrammarRepo grammer_repo;
  GrammarBloc(this.grammer_repo) : super(GrammarInitial()) {
    on<GrammarPastTimeEvent>(generate_past_time);
  }

  FutureOr<void> generate_past_time(
      GrammarPastTimeEvent event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      print("asdasd 1");
      final PastTimeModel? taskModel = await grammer_repo.generate_past_time();
      print("asdasd 2");
      if (taskModel != null) {
        emit(GrammarPastTimeState(pastTimeModel: [taskModel]));
        print("asdasd 3");
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }
}
