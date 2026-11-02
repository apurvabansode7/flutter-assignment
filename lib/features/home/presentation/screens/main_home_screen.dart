import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/bottom_nav_bar.dart';
import 'package:test_app/features/Goal/presentation/screens/goal_screen.dart';
import 'package:test_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_app/features/insights/presentation/screens/insights_screen.dart';
import 'package:test_app/features/journal/presentation/screens/journal_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  static const _navItems = [
    NavItemData(
      label: 'Home',
      img: AppImages.home,
      selectedImg: AppImages.home,
    ),
    NavItemData(
      label: 'Goals',
      img: AppImages.goals,
      selectedImg: AppImages.goals,
    ),
    NavItemData(
      label: 'Journal',
      img: AppImages.journal,
      selectedImg: AppImages.journal,
    ),
    NavItemData(
      label: 'Insights',
      img: AppImages.insights,
      selectedImg: AppImages.insights,
    ),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarColor = switch (_currentIndex) {
      0 => AppColors.headerTop,
      2 => AppColors.journalGradientEnd,
      3 => const Color(0xFFFFFDF7),
      _ => AppColors.white,
    };
    final isDarkStatusBar = _currentIndex == 0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: isDarkStatusBar
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkStatusBar
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(onNavigateToTab: _onTabSelected),
            const GoalsPlaceholder(),
            const JournalScreen(),
            const InsightsScreen(),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(
          items: _navItems,
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}
