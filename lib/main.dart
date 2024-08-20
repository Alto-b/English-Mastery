import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/application/profile_setup_bloc/profile_setup_bloc.dart';
import 'package:english_mastery/application/splash_bloc/splash_bloc.dart';
import 'package:english_mastery/presentation/splash_view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: false),
      dark: ThemeData.dark(useMaterial3: false),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            create: (context) => ProfileSetupBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          // BlocProvider(
          //   create: (context) => HomeBloc(),
          // ),
        ],
        child: MaterialApp(
          title: 'English Mastery',
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: SplashScreenView(),
        ),
      ),
    );
  }
}
