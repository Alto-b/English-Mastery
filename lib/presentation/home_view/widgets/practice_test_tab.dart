import 'dart:developer';

import 'package:english_mastery/presentation/home_view/widgets/home_search_widget.dart';
import 'package:english_mastery/presentation/writing_task_view/writing1.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PracticeTestTabView extends StatelessWidget {
  const PracticeTestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tileList = [
      {
        "title": "Writing",
        "icon": Icons.edit,
        "onClick": () => showWritingBottomSheet()
      },
      {"title": "Reading", "icon": Icons.book, "onClick": () => onClickTest(1)},
      {
        "title": "Listening",
        "icon": Icons.headphones,
        "onClick": () => onClickTest(2)
      },
      {"title": "Speaking", "icon": Icons.mic, "onClick": () => onClickTest(3)},
    ];
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Gap(20),
            HomeSearchWidget(
                screenHeight: screenHeight, screenWidth: screenWidth),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: SizedBox(
                // color: Colors.amber,
                height: screenHeight / 2,
                child: GridView.builder(
                  itemCount: tileList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25.0,
                    childAspectRatio: 1, // Adjust the aspect ratio as needed
                  ),
                  itemBuilder: (context, index) {
                    return _buildTestTile(
                      context,
                      tileList[index]["title"],
                      tileList[index]["icon"],
                      tileList[index]["onClick"], // Pass the onClick callback
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showWritingBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('Writng1'),
              onTap: () {
                // Handle share action
                Get.to(() =>
                    Writing1View()); // Close the bottom sheet after action
              },
            ),
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('Writing2'),
              onTap: () {
                // Handle get link action
                Get.back(); // Close the bottom sheet after action
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors
          .transparent, // Optional: makes the bottom sheet background transparent
      isScrollControlled: true, // Optional: allows full-screen bottom sheets
    );
  }

  void onClickTest(int index) {
    log("Tile clicked $index");

    // Close all previous snackbars before showing the new one
    Get.closeAllSnackbars();

    Get.snackbar(
        'Feature Not Available', 'This feature is coming soon. Stay tuned!',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        animationDuration: const Duration(seconds: 1),
        borderRadius: 15,
        icon: const Icon(Icons.notifications),
        backgroundColor: Colors.blueGrey,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5));
  }

  Widget _buildTestTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(20), // Updated border radius for consistency
      splashColor: Colors.blueGrey, // Subtle splash color
      child: Ink(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Matching the UI consistency
          gradient: const LinearGradient(
            colors: [
              Color(0xFF42A5F5),
              Color(0xFF1E88E5),
              Color(0xFF1E88E5),
            ], // Updated to a blue gradient to match UI theme
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 3),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 38,
              ),
              // const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
