import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<ProceedToHomeEvent>(loadHomePage);
    on<ProceedToProfileSetupEvent>(loadProfileSetup);
  }

  Future<void> loadHomePage(
      ProceedToHomeEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration.zero); // Ensure async handling
    if (!emit.isDone) {
      emit(ProceedToHomeState());
    }
  }

  Future<void> loadProfileSetup(
      ProceedToProfileSetupEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration.zero); // Ensure async handling
    if (!emit.isDone) {
      emit(ProceedToProfileSetupState());
    }
  }
}
