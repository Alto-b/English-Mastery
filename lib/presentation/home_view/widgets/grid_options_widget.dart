import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GridOptionsContainer extends StatelessWidget {
  GridOptionsContainer({
    super.key,
  });
  List<String> title = ['Mock Test'];

  @override
  Widget build(BuildContext context) {
    // Calculate the height of a single grid item
    double itemHeight = MediaQuery.of(context).size.width / 2 - 20;
    // Calculate the number of rows needed
    int rows = (6 / 2).ceil();
    // Calculate the total height of the GridView
    double gridHeight = itemHeight * rows + (8.0 * (rows - 1)) + 10;

    return Card(
      elevation: 15,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: gridHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: const Border.symmetric(
              horizontal: BorderSide(color: Colors.grey)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 30 / 9, // Square items
            ),
            // itemBuilder: (context, index) => OptionBoxesWidget(
            //   icon: const Icon(Icons.volume_up, color: Colors.white, size: 35),
            //   title: 'Text to Speech ${index + 1}',
            //   onTap: () {
            //     // Define the action when the box is tapped
            //   },
            // ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                tileColor: Colors.amber,
                title: Text('Text to Speech ${index + 1}'),
                subtitle: Text("aaaaaaaaaaaa"),
                leading: Icon(Icons.abc),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {},
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionBoxesWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onTap;

  const OptionBoxesWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // This makes the material transparent
      child: InkWell(
        splashColor: Colors.red, // Set the splash color here
        onTap: onTap,
        borderRadius: BorderRadius.circular(
            15), // Ensure the splash effect follows the border radius
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarGlow(
                    glowColor: Colors.blue.shade200,
                    glowCount: 5,
                    glowShape: BoxShape.rectangle,
                    glowRadiusFactor: 15,
                    glowBorderRadius: BorderRadius.circular(15),
                    repeat: false,
                    child: icon),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
