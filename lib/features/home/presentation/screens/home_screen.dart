import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_responsive.dart';
import 'package:test_app/core/constants/app_typography.dart';
import 'package:test_app/features/home/presentation/widgets/goals_card.dart';
import 'package:test_app/features/home/presentation/widgets/horscope_card.dart';
import 'package:test_app/features/home/presentation/widgets/journal_card.dart';
import 'package:test_app/features/home/presentation/widgets/numerology_card.dart';

import '../widgets/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onNavigateToTab});

  final ValueChanged<int>? onNavigateToTab;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _journalCardKey = GlobalKey<JournalCardState>();

  void closeOpenedJournalCard() {
    _journalCardKey.currentState?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebgColor,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction != ScrollDirection.idle) {
            closeOpenedJournalCard();
          }
          return false;
        },
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // 1. Concentric Dial Header
              const HomeHeader(),

              // 2. White Curved Body Content Surface
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32.r),
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: AppResponsive.contentMaxWidth(context),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppResponsive.isTablet(context) ? 32 : 24.w,
                      ).copyWith(top: 32.h, bottom: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section 1: Goals
                          _buildSectionTitle("GOAL'S"),
                          SizedBox(height: 16.h),
                          GoalsCard(
                            onCreateGoal: () => widget.onNavigateToTab?.call(1),
                          ),
                          SizedBox(height: 33.h),

                          // Section 2: Horoscope
                          _buildSectionTitle("TODAY'S HOROSCOPE"),
                          SizedBox(height: 18.h),
                          const HoroscopeCard(),
                          SizedBox(height: 26.h),

                          // Section 3: Numerology
                          _buildSectionTitle("TODAY'S NUMEROLOGY"),
                          SizedBox(height: 12.h),
                          const NumerologyCard(useHomeStyle: true),
                          SizedBox(height: 26.h),

                          // Section 4: Journal
                          _buildSectionTitle("YOUR JOURNAL"),
                          SizedBox(height: 12.h),
                          JournalCard(
                            key: _journalCardKey,
                            onTap: () => widget.onNavigateToTab?.call(2),
                          ),
                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: AppTypography.fontFamily,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: const Color(0xFF8E8E93),
      ),
    );
  }
}
