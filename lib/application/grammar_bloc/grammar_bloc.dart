import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/grammar/articles_quantifiers_model.dart';
import 'package:english_mastery/domain/grammar/comparitives_superlatives_model.dart';
import 'package:english_mastery/domain/grammar/future_time_model.dart';
import 'package:english_mastery/domain/grammar/modals.dart';
import 'package:english_mastery/domain/grammar/passive_causative_model.dart';
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
    on<GrammarComparitivesSuperlativesEvent>(
        generate_comparitives_superlatives);
    on<GrammarModalsEvent>(generate_modals);
    on<GrammarPassiveCausative>(generate_passive_causative);
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
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
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
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
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
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
    }
  }

  FutureOr<void> generate_comparitives_superlatives(
      GrammarComparitivesSuperlativesEvent event,
      Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final ComparativesSuperlativesModel? taskModel =
          await grammer_repo.generate_comparitives_superlatives();
      if (taskModel != null) {
        emit(GrammarComparitivesSuperlativesState(
            comparitivesSuperlativesModel: [taskModel]));
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
    }
  }

  FutureOr<void> generate_modals(
      GrammarModalsEvent event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final ModalsModel? taskModel = await grammer_repo.generate_modals();
      if (taskModel != null) {
        emit(GrammarModalsState(modalsModel: [taskModel]));
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
    }
  }

  FutureOr<void> generate_passive_causative(
      GrammarPassiveCausative event, Emitter<GrammarState> emit) async {
    emit(GrammarLoadingState());
    try {
      final PassiveCausativeModel? taskModel =
          await grammer_repo.generate_passive_causative();
      if (taskModel != null) {
        emit(GrammarPassiveCausativeState(passiveCausativeModel: [taskModel]));
      } else {
        emit(GrammarErrorState(
            errorMessage: "Failed to generate grammar task "));
      }
    } catch (e) {
      emit(GrammarErrorState(
          errorMessage: "Failed to generate grammar task ${e.toString()}"));
    }
  }
}
