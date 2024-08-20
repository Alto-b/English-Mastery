import 'package:english_mastery/application/profile_setup_bloc/profile_setup_bloc.dart';
import 'package:english_mastery/presentation/home_view/home_screen.dart';
import 'package:english_mastery/presentation/profile_view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final genderItems = ['Male', 'Female', 'Others'];
  String? selectedGender;

  String avatarKey = 'Punk'; // Initial key for the avatar
  final List<String> avatarKeys = [
    'man',
    'woman',
    'robot',
    'alien',
    'monster'
  ]; // List of predefined avatar keys
  int currentAvatarIndex = 0;

  void switchAvatar() {
    setState(() {
      // Increment the currentAvatarIndex and cycle back to 0 if it exceeds the list length
      currentAvatarIndex = (currentAvatarIndex + 1) % avatarKeys.length;
      avatarKey = avatarKeys[currentAvatarIndex];
    });
  }

  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs?.getString('userName') ?? "";
      emailController.text = prefs?.getString('userEmail') ?? "";
      avatarKey = prefs?.getString('userAvatar') ??
          avatarKeys[0]; // Default to first avatar if not set
      selectedGender = prefs?.getString('userGender') ??
          genderItems[0]; // Default to first gender if not set
    });
  }

  @override
  Widget build(BuildContext context) {
    // Common InputDecoration for all input fields
    final InputDecoration commonDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText:
          'Enter your value', // Placeholder text, customize for each field
    );

    return BlocListener<ProfileSetupBloc, ProfileSetupState>(
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          // Resetting bloc state to initial to ensure proper functionality on re-entering the screen
          context.read<ProfileSetupBloc>().add(ResetProfileStateEvent());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IntrinsicHeight(
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 10,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(20),
                            Align(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: switchAvatar,
                                    child: AvatarGlow(
                                      glowCount: 1,
                                      glowColor: Colors.blueGrey.shade300,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey.shade200,
                                        child: ClipOval(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: RandomAvatar(
                                              trBackground: true,
                                              avatarKey,
                                              height: 160,
                                              width: 160,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed:
                                            switchAvatar, // Direct function call
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.blue,
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Ensure the padding is zero
                                        constraints:
                                            const BoxConstraints(), // Remove default constraints
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const Gap(8),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: nameController,
                              decoration: commonDecoration.copyWith(
                                hintText:
                                    'Enter your full name', // Customized hint for full name
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }

                                // Check if the name has more than 2 characters
                                if (value.length <= 2) {
                                  return 'Name must be more than 2 characters';
                                }

                                // Regular expression to allow only alphabets and spaces
                                String pattern = r'^[a-zA-Z\s]+$';
                                RegExp regex = RegExp(pattern);

                                if (!regex.hasMatch(value)) {
                                  return 'Name must contain only alphabets';
                                }

                                return null;
                              },
                            ),
                            const Gap(20),
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const Gap(8),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailController,
                              decoration: commonDecoration.copyWith(
                                hintText:
                                    'Enter your email', // Customized hint for email
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                // Regular expression for validating an email address
                                String pattern =
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                RegExp regex = RegExp(pattern);

                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            const Gap(20),
                            const Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const Gap(8),
                            DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: commonDecoration.copyWith(
                                hintText:
                                    "Select Gender", // Customized hint for gender
                              ),
                              value: selectedGender,
                              items: genderItems
                                  .map((gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            Align(
                              child: SizedBox(
                                width: 250,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Handle form submission
                                      context.read<ProfileSetupBloc>().add(
                                            SetupProfileEvent(
                                              userAvatar: avatarKey,
                                              userName: nameController.text,
                                              userEmail: emailController.text,
                                              userGender: selectedGender!,
                                            ),
                                          );
                                    } else {
                                      print(
                                          "Form is not valid. Please fill in the required fields.");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    "PROCEED",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(20)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
