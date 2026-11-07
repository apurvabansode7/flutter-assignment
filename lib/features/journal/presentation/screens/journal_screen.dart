import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

import 'package:test_app/features/home/presentation/widgets/journal_notebook_cover.dart';
import 'package:test_app/features/journal/data/datasources/journal_mock_data_source.dart';
import 'package:test_app/features/journal/data/models/journal_entry_model.dart';
import 'package:test_app/features/journal/presentation/bloc/journal_bloc.dart';
import 'package:test_app/features/journal/presentation/bloc/journal_event.dart';
import 'package:test_app/features/journal/presentation/bloc/journal_state.dart';
import 'package:test_app/features/journal/presentation/widgets/add_entry_bottom_sheet.dart';
import 'package:test_app/features/journal/presentation/widgets/journal_entry_card.dart';
import 'package:test_app/features/journal/presentation/widgets/journal_month_filter.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          JournalBloc(dataSource: JournalMockDataSource())
            ..add(LoadJournalEvent()),
      child: const JournalView(),
    );
  }
}

class JournalView extends StatefulWidget {
  const JournalView({super.key});

  @override
  State<JournalView> createState() => _JournalViewState();
}

class _JournalViewState extends State<JournalView> {
  final List<String> _months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _selectedMonth = 'Oct';

  void _onMonthSelected(String month) {
    setState(() {
      _selectedMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD8E9EA), // Soft celestial pale cyan matching Figma
              AppColors.white,
            ],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),

                  // Header
                  Text(
                    'Your Journal',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    'A Space To Be You',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6E6E73),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Notebook Cover
                  const Center(
                    child: Hero(
                      tag: 'journal_screen_notebook_cover',
                      child: JournalNotebookCover(),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Month Filter
                  JournalMonthFilter(
                    months: _months,
                    selectedMonth: _selectedMonth,
                    onMonthSelected: _onMonthSelected,
                  ),

                  SizedBox(height: 17.h),

                  // Star Divider
                  Center(
                    child: Image.asset(
                      AppImages.star,
                      width: 204.w,
                      height: 17.h,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Recent Entries Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Recent Entries',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),

                      TextButton.icon(
                        onPressed: () {
                          AddEntryBottomSheet.show(context);
                        },
                        icon: Icon(
                          Icons.add,
                          size: 16.r,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          'Add Entry',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // BLoC Journal Data
                  BlocBuilder<JournalBloc, JournalState>(
                    builder: (context, state) {
                      if (state is JournalLoading || state is JournalInitial) {
                        return _buildShimmer();
                      }

                      if (state is JournalError) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                state.message,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.dark,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<JournalBloc>().add(
                                    LoadJournalEvent(),
                                  );
                                },
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is JournalLoaded) {
                        if (state.entries.isEmpty) {
                          return const Center(
                            child: Text('No journal entries yet.'),
                          );
                        }

                        final filtered = state.entries
                            .where(
                              (e) =>
                                  e.month.toLowerCase() ==
                                  _selectedMonth.toLowerCase(),
                            )
                            .toList();
                        final entriesToRender = filtered.isNotEmpty
                            ? filtered
                            : state.entries;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: entriesToRender.length,
                          itemBuilder: (context, index) {
                            final entry = entriesToRender[index];

                            return JournalEntryCard(
                              entry: entry,
                              onTap: () {
                                _showEntryDetail(context, entry);
                              },
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer Loading
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8ECEE),
      highlightColor: const Color(0xFFF7F9FA),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            width: double.infinity,
            height: 105.h,
            margin: EdgeInsets.only(bottom: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
        ),
      ),
    );
  }

  // Journal Entry Details
  void _showEntryDetail(BuildContext context, JournalEntryModel entry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD1D1D6),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            SizedBox(height: 18.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.title,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily2,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            SizedBox(height: 4.h),

            Text(
              '${entry.month} ${entry.date.day}, '
              '${entry.date.year} • ${entry.time}',
              style: TextStyle(
                fontFamily: AppTypography.fontFamily2,
                fontSize: 12.5.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 14.h),

            Text(
              entry.content,
              style: TextStyle(
                fontFamily: AppTypography.fontFamily2,
                fontSize: 14.sp,
                height: 1.5,
                color: const Color(0xFF333333),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
