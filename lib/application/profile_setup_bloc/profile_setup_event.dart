part of 'profile_setup_bloc.dart';

sealed class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object> get props => [];
}

class SetupProfileEvent extends ProfileSetupEvent {
  final String userAvatar;
  final String userName;
  final String userEmail;
  final String userGender;

  const SetupProfileEvent({
    required this.userAvatar,
    required this.userName,
    required this.userEmail,
    required this.userGender,
  });

  @override
  List<Object> get props => [userAvatar, userName, userEmail, userGender];
}

class LogOutEvent extends ProfileSetupEvent {}

class ResetProfileStateEvent extends ProfileSetupEvent {
  @override
  List<Object> get props => [];
}
