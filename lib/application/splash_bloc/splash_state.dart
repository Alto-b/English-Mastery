part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

class ProceedToProfileSetupState extends SplashState {}

class ProceedToHomeState extends SplashState {}
