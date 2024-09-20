import 'package:flutter/material.dart';

class MockTestTabView extends StatelessWidget {
  const MockTestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("mock"),
        ],
      )),
    );
  }
}
