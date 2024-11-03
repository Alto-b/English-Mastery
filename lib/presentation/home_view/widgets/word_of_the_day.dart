import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WordOfTheDayWidget extends StatelessWidget {
  const WordOfTheDayWidget({
    super.key,
    required this.randomWord,
  });

  final MapEntry<String, String> randomWord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Color(0xFF42A5F5).withOpacity(0.5),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons
                        .bookmark, // or any other icon related to words/learning
                    color: Color(0xFF42A5F5),
                    size: 20,
                  ),
                  Gap(10),
                  Text(
                    "Word Of The Day",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF42A5F5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              SizedBox(height: 10),
              Text(
                "${randomWord.key}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "${randomWord.value}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
