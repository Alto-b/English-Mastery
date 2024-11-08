import 'package:english_mastery/domain/word_of_the_day_model.dart';
import 'package:english_mastery/presentation/grammar_view/grammar_screen.dart';
import 'package:english_mastery/presentation/home_view/widgets/word_of_the_day.dart';
import 'package:english_mastery/presentation/vocabulary_view.dart/vocabulary_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GeneralTestTabView extends StatelessWidget {
  const GeneralTestTabView({super.key});

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
            const Gap(20),
            WordOfTheDayWidget(randomWord: randomWord),
            const Gap(20),
            GeneralSubListTile(
              title: "Grammar",
              subtitle: "Explore Grammar Tasks",
              leadingIcon: Icons.book_online_rounded,
              onTap: () {
                Get.to(GrammarScreen());
              },
            ),
            GeneralSubListTile(
              title: "Vocabulary",
              subtitle: "Explore Vocabulary Tasks",
              leadingIcon: Icons.book_outlined,
              onTap: () {
                Get.to(VocabularyScreen());
              },
            ),
          ],
        ),
      )),
    );
  }
}

class GeneralSubListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final VoidCallback? onTap;

  const GeneralSubListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon = Icons.abc,
    this.trailingIcon = Icons.arrow_forward_ios_sharp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              horizontalTitleGap: 16,
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  leadingIcon,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.blue[800]?.withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
              trailing: Icon(
                trailingIcon,
                color: Colors.blueAccent,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
