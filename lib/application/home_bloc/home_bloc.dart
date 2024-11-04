import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeSuccessEvent>(loadHomePage);
  }

  FutureOr<void> loadHomePage(
      HomeSuccessEvent event, Emitter<HomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Future.delayed(const Duration(seconds: 2));
      emit(HomeSuccessState(
        userName: prefs.getString('userName') ?? "",
        userEmail: prefs.getString('userEmail') ?? "",
        userGender: prefs.getString('userGender') ?? "",
        userAvatar: prefs.getString('userAvatar') ?? "",
      ));
    } catch (e) {}
  }
}
