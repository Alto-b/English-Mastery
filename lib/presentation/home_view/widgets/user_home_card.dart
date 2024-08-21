import 'package:avatar_glow/avatar_glow.dart';
import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/presentation/profile_view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

class UserHomeCard extends StatelessWidget {
  const UserHomeCard({
    super.key,
    required this.screenHeight,
    required this.state,
  });

  final double screenHeight;
  final HomeSuccessState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(state: state),
            ));
      },
      child: Container(
        // height: screenHeight / 8,
        child: Card(
          // color: Colors.black54,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.grey,
                width: 0.2,
                strokeAlign: BorderSide.strokeAlignInside),
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 40,
          shadowColor: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Hero(
                  tag: "UserAvatar",
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AvatarGlow(
                        glowCount: 15,
                        glowShape: BoxShape.circle,
                        repeat: false,
                        glowColor: Colors.blue.shade200,
                        child: RandomAvatar(
                          trBackground: true,
                          state.userAvatar,
                          height: 60,
                          width: 60,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Hello ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .black, // Specify a color for this text part
                              ),
                            ),
                            TextSpan(
                              text: state.userName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.withOpacity(
                                    0.5), // Different color for the userName part
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.userEmail,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.menu)
                // IconButton(
                //   onPressed: () {
                //     // Add action here
                //   },
                //   icon: const Icon(Icons.arrow_forward_ios),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
