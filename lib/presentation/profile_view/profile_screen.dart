import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/application/profile_setup_bloc/profile_setup_bloc.dart';
import 'package:english_mastery/presentation/profile_view/edit_profile_view.dart';
import 'package:english_mastery/presentation/splash_view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileScreen extends StatelessWidget {
  final HomeSuccessState state;

  const ProfileScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tileSize = (screenWidth - 48) / 2; // Subtract padding and divide by 2

    return BlocListener<ProfileSetupBloc, ProfileSetupState>(
      listener: (context, state) async {
        if (state is LogOutState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashScreenView(),
              ),
              (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey.shade200, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Hero(
                          tag: "UserAvatar",
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipOval(
                                child: RandomAvatar(
                                  state.userAvatar,
                                  trBackground: true,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.userName,
                          // style: Theme.of(context).textTheme.headline6!.copyWith(
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black87,
                          //     ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.userEmail,
                          // style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          //       color: Colors.grey.shade600,
                          //     ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1, // Makes the tiles square
                      padding: EdgeInsets.zero,
                      children: [
                        _buildGridTile(
                          context,
                          icon: Icons.account_circle_outlined,
                          title: "Profile",
                          tileSize: tileSize,
                          onTap: () {
                            // Add navigation to profile screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfileScreen(),
                                ));
                          },
                        ),
                        _buildGridTile(
                          context,
                          icon: Icons.settings_outlined,
                          title: "Settings",
                          tileSize: tileSize,
                          onTap: () {
                            // Add navigation to settings screen
                          },
                        ),
                        _buildGridTile(
                          context,
                          icon: Icons.help_outline,
                          title: "Help & Support",
                          tileSize: tileSize,
                          onTap: () {
                            // Add navigation to help & support screen
                          },
                        ),
                        _buildGridTile(
                          context,
                          icon: Icons.logout,
                          title: "Logout",
                          tileSize: tileSize,
                          onTap: () {
                            _showLogoutConfirmationDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents the dialog from closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
              const SizedBox(width: 8),
              const Text(
                'Confirm Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                context.read<ProfileSetupBloc>().add(LogOutEvent());
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double tileSize,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade50, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.blueGrey.shade100,
          child: SizedBox(
            width: tileSize,
            height: tileSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.blueGrey.shade700, size: 40),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  // style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.black87,
                  //     ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
