import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';
import '../../domain/entities/insight_data.dart';

class InsightsPeriodTabs extends StatelessWidget {
  const InsightsPeriodTabs({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodSelected,
  });

  final InsightPeriod selectedPeriod;
  final ValueChanged<InsightPeriod> onPeriodSelected;

  static const _periods = [
    (InsightPeriod.yesterday, 'YESTERDAY'),
    (InsightPeriod.today, 'TODAY'),
    (InsightPeriod.tomorrow, 'TOMORROW'),
    (InsightPeriod.week, 'WEEK'),
    (InsightPeriod.month, 'MONTH'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h.clamp(40.0, 56.0),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < _periods.length; i++) ...[
                _buildTab(
                  period: _periods[i].$1,
                  label: _periods[i].$2,
                  isSelected: _periods[i].$1 == selectedPeriod,
                ),
                if (i < _periods.length - 1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child:
                    Row(
                      children: [
                        Container(
                          width: 2.r,
                          height: 2.r,
                          decoration: const BoxDecoration(
                            color: AppColors.tabColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width:4.w,),
                        Container(
                          width: 5.r,
                          height: 5.r,
                          decoration: const BoxDecoration(
                            color: AppColors.tabColor,
                            shape: BoxShape.circle
                          ),
                        ),
                        SizedBox(width:4.w,),
                        Container(
                          width: 2.r,
                          height: 2.r,
                          decoration: const BoxDecoration(
                            color: AppColors.tabColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required InsightPeriod period,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onPeriodSelected(period),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              letterSpacing: 0.8,
              color: isSelected
                  ? AppColors.headerTop
                  : AppColors.horoscopeSectionHeader
            ),
            child: Text(label),
          ),
          SizedBox(height: 5.h),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isSelected ? 1.0 : 0.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 15.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: AppColors.headerTop,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 4.5.r,
                  height: 4.5.r,
                  decoration: const BoxDecoration(
                    color: AppColors.headerTop,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  width: 15.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: AppColors.headerTop,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
