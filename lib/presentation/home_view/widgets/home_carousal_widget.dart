import 'package:flutter/material.dart';

class HomeCarousalWidget extends StatelessWidget {
  const HomeCarousalWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 4,
      width: screenWidth,
      //   child: CarousalView(
      //   elevation: 5,
      //   backgroundColor: Colors.grey,
      //   itemExtent: screenWidth - 50,
      //   itemSnapping: true,
      //   padding: EdgeInsets.all(5),
      //   children: List.generate(
      //     10,
      //     (int index) {
      //       return Container(
      //         decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image: AssetImage('assets/logo/gemini.png'))),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
