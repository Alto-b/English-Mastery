part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeSuccessState extends HomeState {
  final String userName;
  final String userEmail;
  final String userGender;
  final String userAvatar;
  HomeSuccessState({
    required this.userName,
    required this.userEmail,
    required this.userGender,
    required this.userAvatar,
  });
  @override
  List<Object> get props => [userName, userAvatar, userEmail, userGender];
}

class HomeFailureState extends HomeState {
  final String error;
  const HomeFailureState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
