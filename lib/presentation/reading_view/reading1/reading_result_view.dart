import 'package:english_mastery/application/reading_bloc/reading_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadingResultView extends StatelessWidget {
  const ReadingResultView(
      {super.key,
      this.trueFalseScore,
      this.multipleChoiceScore,
      this.completeTheSentenceScore});
  final trueFalseScore;
  final multipleChoiceScore;
  final completeTheSentenceScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reading Result")),
      body: BlocBuilder<ReadingBloc, ReadingState>(
        builder: (context, state) {
          if (state is ReadingScoreGenerated) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      color: Colors.blueAccent,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Your Reading Practice Scores",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 30),
                    ScoreTile(
                      label: "True/False Score",
                      score: state.trueFalseScore,
                      icon: Icons.check_circle_outline,
                    ),
                    const SizedBox(height: 20),
                    ScoreTile(
                      label: "Multiple Choice Score",
                      score: state.multipleChoiceScore,
                      icon: Icons.list_alt_outlined,
                    ),
                    const SizedBox(height: 20),
                    ScoreTile(
                      label: "Complete the Sentence Score",
                      score: state.completeTheSentenceScore,
                      icon: Icons.text_snippet_outlined,
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({
    Key? key,
    required this.label,
    required this.score,
    required this.icon,
  }) : super(key: key);

  final String label;
  final int score;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 30),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        Text(
          "${score.toString()} %",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
        ),
      ],
    );
  }
}
