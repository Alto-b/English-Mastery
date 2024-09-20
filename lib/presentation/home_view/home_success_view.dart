import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:english_mastery/application/home_bloc/home_bloc.dart';
import 'package:english_mastery/presentation/gemini/gemini.dart';
import 'package:english_mastery/presentation/home_view/widgets/grid_options_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_carousal_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_search_widget.dart';
import 'package:english_mastery/presentation/home_view/widgets/home_tabbar.dart';
import 'package:english_mastery/presentation/home_view/widgets/mock_test_tab.dart';
import 'package:english_mastery/presentation/home_view/widgets/practice_test_tab.dart';
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

    return DefaultTabController(
      length: 2, // Specify the number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight / 5,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Place your widgets that you want in the AppBar here
              UserHomeCard(screenHeight: screenHeight, state: state),
              // const Gap(10),
              // HomeSearchWidget(
              //     screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            dividerColor: Colors.amber,
            indicatorWeight: 3,
            automaticIndicatorColorAdjustment: true,
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            tabs: [
              Tab(text: "Mock test"),
              Tab(text: "Practice"),
            ],
          ),
        ),
        body: TabBarView(children: [MockTestTabView(), PracticeTestTabView()]),
      ),
    );
  }
}
