import 'package:flutter/material.dart';

class HomeTabBarWidget extends StatelessWidget {
  const HomeTabBarWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight / 14,
      color: Colors.amber,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          width: screenWidth / 3,
          height: screenHeight / 18,
          color: Colors.red,
          child: const Text("Practice"),
        ),
        Container(
          width: screenWidth / 3,
          height: screenHeight / 18,
          color: Colors.green,
          child: const Text("Mock Test"),
        )
      ]),
    );
  }
}
