import 'package:english_mastery/domain/word_of_the_day_model.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_search_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/word_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MockTestTabView extends StatelessWidget {
  const MockTestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    WordOfTheDayModel model = WordOfTheDayModel();
    MapEntry<String, String> randomWord = model.getWordOfTheDay();
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Gap(20),
            WordOfTheDayWidget(randomWord: randomWord),
            Gap(20),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                subtitle: Text("aaaaaaaaaaaaaaa"),
                tileColor: Colors.amber,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                horizontalTitleGap: 50,
                leading: Icon(Icons.abc),
                title: Text("Grammar"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                subtitle: Text("aaaaaaaaaaaaaaa"),
                tileColor: Colors.amber,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                horizontalTitleGap: 50,
                leading: Icon(Icons.abc),
                title: Text("Vocabulary"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                subtitle: Text("aaaaaaaaaaaaaaa"),
                tileColor: Colors.amber,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                horizontalTitleGap: 50,
                leading: Icon(Icons.abc),
                title: Text("Grammar"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
