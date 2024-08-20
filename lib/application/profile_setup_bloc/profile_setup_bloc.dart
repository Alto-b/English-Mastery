import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(ProfileSetupInitial()) {
    on<SetupProfileEvent>(setupProfile);
    on<LogOutEvent>(logOutUser);
    on<ResetProfileStateEvent>(resetProfileBloc);
  }

  FutureOr<void> setupProfile(
      SetupProfileEvent event, Emitter<ProfileSetupState> emit) async {
    try {
      // Get an instance of SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Store the user details in SharedPreferences
      await prefs.setString('userAvatar', event.userAvatar);
      await prefs.setString('userName', event.userName);
      await prefs.setString('userEmail', event.userEmail);
      await prefs.setString('userGender', event.userGender);
      await prefs.setBool("isUserLoggedIn", true);
      // Emit a success state if needed
      emit(ProfileSetupSuccess());
    } catch (e) {
      // Emit an error state if something goes wrong
      emit(ProfileSetupFailure(error: e.toString()));
    }
  }

  Future<void> logOutUser(
      LogOutEvent event, Emitter<ProfileSetupState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isUserLoggedIn", false);

      emit(LogOutState());
    } catch (e) {
      log("error while logout $e");
    }
  }

  FutureOr<void> resetProfileBloc(
      ResetProfileStateEvent event, Emitter<ProfileSetupState> emit) {
    emit(ProfileSetupInitial());
  }
}
