import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';

class RecordingErrorWidget extends StatelessWidget {
  RecordingErrorWidget({
    super.key,
    required this.state,
  });
  final RecordingError state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error: ${state.error}',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
