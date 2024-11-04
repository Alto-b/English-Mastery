import 'dart:developer';
import 'package:english_mastery/application/splash_bloc/splash_bloc.dart';
import 'package:english_mastery/presentation/home_view/home_screen.dart';
import 'package:english_mastery/presentation/profile_setup_view/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  bool? isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    log("Splash initState called");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserLoginStatus();
    });
  }

  Future<void> _checkUserLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn = prefs.getBool('isUserLoggedIn');
    log("User logged in: $isUserLoggedIn");
    if (isUserLoggedIn == true) {
      BlocProvider.of<SplashBloc>(context).add(ProceedToHomeEvent());
    } else {
      BlocProvider.of<SplashBloc>(context).add(ProceedToProfileSetupEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is ProceedToProfileSetupState) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            if (mounted) {
              // Check if widget is still mounted
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
              );
            }
          });
        } else if (state is ProceedToHomeState) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            if (mounted) {
              // Check if widget is still mounted
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          });
        }
      },
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "English Mastery",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(), // Show a loading indicator
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
