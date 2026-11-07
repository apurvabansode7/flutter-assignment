import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_responsive.dart';
import 'package:test_app/core/constants/app_typography.dart';
import 'package:test_app/features/home/presentation/widgets/numerology_card.dart';
import 'package:test_app/features/insights/data/repositories/insights_repository_impl.dart';
import 'package:test_app/features/insights/domain/entities/insight_data.dart';
import 'package:test_app/features/insights/presentation/bloc/insights_bloc.dart';
import 'package:test_app/features/insights/presentation/bloc/insights_event.dart';
import 'package:test_app/features/insights/presentation/bloc/insights_state.dart';
import 'package:test_app/features/insights/presentation/widgets/astrology_profile_header.dart';
import 'package:test_app/features/insights/presentation/widgets/destiny_card.dart';
import 'package:test_app/features/insights/presentation/widgets/direction_and_colour_section.dart';
import 'package:test_app/features/insights/presentation/widgets/focus_career_card.dart';
import 'package:test_app/features/insights/presentation/widgets/fun_facts_card.dart';
import 'package:test_app/features/insights/presentation/widgets/insights_period_tabs.dart';
import 'package:test_app/features/insights/presentation/widgets/today_horoscope_card.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          InsightsBloc(repository: InsightsRepositoryImpl())
            ..add(const LoadInsights(InsightPeriod.today)),
      child: const _InsightsScreenView(),
    );
  }
}

class _InsightsScreenView extends StatelessWidget {
  const _InsightsScreenView();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        key: const Key('insights_scroll_view'),
     
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── 1. Ambient Celestial Background that SCROLLS naturally with content ──
            Positioned(
              top: -80.h,
              left: 0,
              right: 0,
              height: 350.h + topPadding,
              child: IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFFDF7),
                        Color(0xFFFEFBF0),
                        Color(0xFFFAF6E6),
                        AppColors.white,
                      ],
                      stops: [0.0, 0.45, 0.75, 1.0],
                    ),
                  ),
                  child: Image.asset(
                    width: 82.w,
                    height: 14.h,
                    AppImages.insightBg,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // ── 2. Scrollable Foreground Content ──
            SafeArea(
              bottom: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppResponsive.contentMaxWidth(context),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.horizontalPadding(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),

                        // 1. Screen Title
                        Text(
                          'Insights',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.dark,
                            letterSpacing: -0.5,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // 2. Period Tabs (Yesterday • Today • Tomorrow • Week • Month)
                        BlocBuilder<InsightsBloc, InsightsState>(
                          builder: (context, state) {
                            return InsightsPeriodTabs(
                              selectedPeriod: state.selectedPeriod,
                              onPeriodSelected: (period) {
                                context.read<InsightsBloc>().add(
                                      ChangeInsightsPeriod(period),
                                    );
                              },
                            );
                          },
                        ),

                        // 3. Dynamic Period Content
                        BlocBuilder<InsightsBloc, InsightsState>(
                          builder: (context, state) {
                            if (state.status == InsightsStatus.loading &&
                                state.insightData == null) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(40),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state.status == InsightsStatus.failure) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(40),
                                  child: Text(
                                    state.errorMessage ??
                                        'Something went wrong',
                                  ),
                                ),
                              );
                            }

                            final data = state.insightData;
                            if (data == null) {
                              return const SizedBox.shrink();
                            }

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Column(
                                key: ValueKey(state.selectedPeriod),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 3A. Astrology Profile Header (Wheel, Signs, User info)
                                    SizedBox(height: 20.h),
                                  AstrologyProfileHeader(data: data),

                                  SizedBox(height: 20.h),

                                  // 3B. Astrology Section Header
                                  _buildSectionTitle('ASTROLOGY'),

                                  SizedBox(height: 12.h),

                                  // 3C. Focus of the Day Card
                                  FocusCareerCard(focusArea: data.focusArea),

                                  SizedBox(height: 16.h),

                                  // 3D. Today's Horoscope Card
                                  TodayHoroscopeCard(
                                    title: _getHoroscopeTitle(
                                      state.selectedPeriod,
                                    ),
                                    description: data.horoscopeText,
                                  ),

                                  SizedBox(height: 20.h),

                                  // 3E. Favourable Direction & Lucky Colour Section
                                  DirectionAndColourSection(
                                    direction: data.favourableDirection,
                                    colour: data.luckyColour,
                                  ),

                                  SizedBox(height: 20.h),

                                  // 3F. Fun Facts Card
                                  FunFactsCard(description: data.funFactText),

                                  SizedBox(height: 26.h),

                                  // 3G. Numerology Section Header
                                  _buildSectionTitle('NUMEROLOGY'),

                                  SizedBox(height: 12.h),

                                  // 3H. Numerology Lucky Number Card
                                  NumerologyCard(
                                    luckyNumber: data.luckyNumber,
                                    guidanceText: data.guidanceText,
                                    showLuckyNumber: true,
                                  ),

                                  SizedBox(height: 16.h),

                                  // 3I. Destiny Number Card
                                  DestinyCard(
                                    destinyNumber: data.destinyNumber,
                                    destinyTitle: data.destinyTitle,
                                  ),

                                  // 3J. Bottom Padding (clean space above nav bar)
                                  SizedBox(height: 36.h),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: AppTypography.fontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          color: const Color(0xFF8E8E93),
        ),
      ),
    );
  }

  String _getHoroscopeTitle(InsightPeriod period) {
    switch (period) {
      case InsightPeriod.yesterday:
        return 'Your yesterday’s horoscope';
      case InsightPeriod.today:
        return 'Your today’s horoscope';
      case InsightPeriod.tomorrow:
        return 'Your tomorrow’s horoscope';
      case InsightPeriod.week:
        return 'Your this week’s horoscope';
      case InsightPeriod.month:
        return 'Your this month’s horoscope';
    }
  }
}
