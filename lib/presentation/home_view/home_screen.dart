import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/presentation/home_view/home_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeSuccessEvent());
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccessState) {
          return HomeSuccessStateWidget(state: state); // Pass the state here
        } else if (state is HomeFailureState) {
          return Scaffold(
            body: Center(child: Text(state.error)), // Center the error message
          );
        } else {
          return const Scaffold(
            body: Center(
                child:
                    CircularProgressIndicator()), // Center the progress indicator
          );
        }
      },
    );
  }
}
