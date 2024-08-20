part of 'profile_setup_bloc.dart';

sealed class ProfileSetupState extends Equatable {
  const ProfileSetupState();

  @override
  List<Object> get props => [];
}

final class ProfileSetupInitial extends ProfileSetupState {}

class ProfileSetupSuccess extends ProfileSetupState {}

class ProfileSetupFailure extends ProfileSetupState {
  final String error;

  const ProfileSetupFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class LogOutState extends ProfileSetupState {}
