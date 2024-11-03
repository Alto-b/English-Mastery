import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:english_mastery/domain/speaking/speaking_generate_model.dart';
import 'package:english_mastery/infrastructure/speaking_repo.dart';
import 'package:equatable/equatable.dart';

part 'speaking_question_event.dart';
part 'speaking_question_state.dart';

class SpeakingQuestionBloc
    extends Bloc<SpeakingQuestionEvent, SpeakingQuestionState> {
  final SpeakingRepo speakingRepo;
  SpeakingQuestionBloc(this.speakingRepo) : super(SpeakingQuestionInitial()) {
    on<Speaking2GenerateQuestionEvent>(generateSpeaking2);
  }

  FutureOr<void> generateSpeaking2(Speaking2GenerateQuestionEvent event,
      Emitter<SpeakingQuestionState> emit) async {
    emit(SpeakingQuestionInitial());
    try {
      final SpeakingGenerateTaskModel? taskModel =
          await speakingRepo.speaking_generate_task();
      if (taskModel != null) {
        emit(Speaking2QuestionSuccessState(
            speakingGenerateTaskModel: [taskModel]));
      } else {
        emit(Speaking2QuestionSuccessErrorState(
            message: "Failed to fetch speaking task"));
      }
    } catch (e) {
      emit(Speaking2QuestionSuccessErrorState(message: "Error:$e"));
    }
  }
}
