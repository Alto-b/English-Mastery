import 'package:english_mastery/application/speaking_bloc/speaking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RecordingInitialWidget extends StatelessWidget {
  const RecordingInitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("data"),
            Spacer(),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SpeakingBloc>().add(StartRecording());
                  },
                  child: Icon(Icons.mic),
                  // child: Text('Start Recording'),
                ),
                Text(
                  'Start Recording',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            Gap(20)
          ],
        ),
      ),
    );
  }
}
