part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class ProceedToProfileSetupEvent extends SplashEvent {}

class ProceedToHomeEvent extends SplashEvent {}
