import 'dart:async';

import 'package:english_mastery/application/reading_bloc/reading_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingLoadingFailedWidget extends StatefulWidget {
  const ReadingLoadingFailedWidget({super.key});

  @override
  _ReadingLoadingFailedWidgetState createState() =>
      _ReadingLoadingFailedWidgetState();
}

class _ReadingLoadingFailedWidgetState
    extends State<ReadingLoadingFailedWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleRetry();
  }

  void _scheduleRetry() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      context.read<ReadingBloc>().add(loadReadingEvent());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.error_outline,
          //   color: Colors.redAccent,
          //   size: 50,
          // ),
          // const SizedBox(height: 20),

          // const SizedBox(height: 20),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     context.read<ReadingBloc>().add(loadReadingEvent());
          //     _scheduleRetry();
          //   },
          //   icon: Icon(Icons.refresh),
          //   label: Text("Retry"),
          // ),
          const SizedBox(height: 20),
          CupertinoActivityIndicator(),
          const SizedBox(height: 20),
          Text(
            "Failed to load reading task.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Text(
            "Retrying in a few seconds...",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
