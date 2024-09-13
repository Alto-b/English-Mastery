import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/presentation/gemini/gemini.dart';
import 'package:english_mastery/presentation/home_view/widgets/grid_options_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_carousal_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_search_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_tabbar.dart';
import 'package:english_mastery/presentation/home_view/widgets/user_home_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeSuccessStateWidget extends StatelessWidget {
  final HomeSuccessState state;

  const HomeSuccessStateWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate the height needed for the user card
    final double userCardHeight = screenHeight / 7;
    // Calculate the remaining height for the grid
    final double gridAvailableHeight = screenHeight - userCardHeight - 60 - 20;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            HomeSearchWidget(
                screenHeight: screenHeight, screenWidth: screenWidth),
            // HomeCarousalWidget(
            //     screenHeight: screenHeight, screenWidth: screenWidth),
            const Gap(10),
            // HomeTabBarWidget(
            //     screenWidth: screenWidth, screenHeight: screenHeight),
            const Gap(10),
            UserHomeCard(screenHeight: screenHeight, state: state),
            const Gap(10),

            const Gap(10),
            GridOptionsContainer(),
            const Gap(10),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => GeminiPage(),
            //         ));
            //   },
            //   child: Container(
            //     color: Colors.red,
            //     height: 150,
            //     width: screenWidth,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
