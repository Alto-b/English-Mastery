import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/grammar/articles_quantifiers_model.dart';
import 'package:english_mastery/domain/grammar/future_time_model.dart';
import 'package:english_mastery/domain/grammar/past_time_model.dart';
import 'package:english_mastery/infrastructure/grammar_repo.dart';
import 'package:equatable/equatable.dart';

part 'grammar_event.dart';
part 'grammar_state.dart';

class GrammarBloc extends Bloc<GrammarEvent, GrammarState> {
  final GrammarRepo grammer_repo;
  GrammarBloc(this.grammer_repo) : super(GrammarInitial()) {
    on<GrammarPastTimeEvent>(generate_past_time);
    on<GrammarFutureTimeEvent>(generate_future_time);
    on<GrammarArticlesQuantifiersEvent>(generate_articles_quantifiers);
  }

  FutureOr<void> generate_past_time(
      GrammarPastTimeEvent event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final PastTimeModel? taskModel = await grammer_repo.generate_past_time();
      if (taskModel != null) {
        emit(GrammarPastTimeState(pastTimeModel: [taskModel]));
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generate_future_time(
      GrammarFutureTimeEvent event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final FutureTimeModel? taskModel =
          await grammer_repo.generate_future_time();
      if (taskModel != null) {
        emit(GrammarFutureTimeState(futureTimeModel: [taskModel]));
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate vocabulary task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate vocabulary task ${e.toString()}"));
    }
  }

  FutureOr<void> generate_articles_quantifiers(
      GrammarArticlesQuantifiersEvent event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final ArticlesQuantifiersModel? taskModel =
          await grammer_repo.generate_articles_quantifiers();
      if (taskModel != null) {
        emit(GrammarArticlesQuantifiersState(
            articlesQuantifiersModel: [taskModel]));
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
