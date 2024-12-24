import 'package:english_mastery/application/reading_bloc/reading_bloc.dart';
import 'package:english_mastery/presentation/reading_view/reading1/widgets/reading1view_widget.dart';
import 'package:english_mastery/presentation/reading_view/reading1/widgets/reading_fail_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reading1Screen extends StatelessWidget {
  const Reading1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<ReadingBloc>().add(loadReadingEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reading"),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       context.read<ReadingBloc>().add(loadReadingEvent());
          //     },
          //     icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<ReadingBloc, ReadingState>(
        builder: (context, state) {
          if (state is Reading422State) {
            return Center(
                child: Column(
              children: [Text(state.errorMessage)],
            ));
          }
          if (state is ReadingLoadingState) {
            return const Center(
                child: CupertinoActivityIndicator(
              color: Colors.blue,
            ));
          }
          if (state is ReadingLoadingSuccessState) {
            return ReadingViewWidget(
              state: state,
            );
          }
          return const ReadingLoadingFailedWidget();
        },
      ),
    );
  }
}
