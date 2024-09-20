import 'package:flutter/material.dart';

class PracticeTestTabView extends StatelessWidget {
  const PracticeTestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tileList = [
      {"title": "Writing", "icon": Icons.edit, "onClick": () => onClick(0)},
      {"title": "Reading", "icon": Icons.book, "onClick": () => onClick(1)},
      {
        "title": "Listening",
        "icon": Icons.headphones,
        "onClick": () => onClick(2)
      },
      {"title": "Speaking", "icon": Icons.mic, "onClick": () => onClick(3)},
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
    );
  }

  void onClick(int index) {
    print("Tile clicked $index");
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
      splashColor: Colors.blueAccent.withOpacity(0.2), // Subtle splash color
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
