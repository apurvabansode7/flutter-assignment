import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/bottom_nav_bar.dart';
import 'package:test_app/features/Goal/presentation/screens/goal_screen.dart';
import 'package:test_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_app/features/insights/presentation/screens/insights_screen.dart';
import 'package:test_app/features/journal/presentation/screens/journal_screen.dart';
import 'package:test_app/features/journal/presentation/widgets/book_opening_animation.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  bool _isOpeningBook = false;

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
    if (index == 2 && _currentIndex != 2) {
      // Trigger book-opening animation before navigating to Journal
      setState(() => _isOpeningBook = true);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarColor = switch (_currentIndex) {
      0 => AppColors.headerTop,
      2 => Colors.transparent,
      3 => Colors.transparent,
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
        body: Stack(
          children: [
            IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(onNavigateToTab: _onTabSelected),
                const GoalsPlaceholder(),
                const JournalScreen(),
                const InsightsScreen(),
              ],
            ),
            if (_isOpeningBook)
              BookOpeningOverlay(
                onComplete: () {
                  if (!mounted) return;
                  setState(() {
                    _isOpeningBook = false;
                    _currentIndex = 2;
                  });
                },
              ),
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
