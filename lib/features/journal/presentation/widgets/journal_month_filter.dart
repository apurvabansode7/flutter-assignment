
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';

class JournalMonthFilter extends StatelessWidget {
  const JournalMonthFilter({
    super.key,
    required this.months,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  final List<String> months;
  final String selectedMonth;
  final ValueChanged<String> onMonthSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: months.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final month = months[index];

          final isSelected =
              month.toLowerCase() == selectedMonth.toLowerCase();

          return GestureDetector(
            onTap: () => onMonthSelected(month),
            child: Container(
              width: 110.w,
              height: 38.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF13434C)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(19.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.horoscopeCardBackground
                      : const Color(0xFFE5ECEE),
                  width: 1.w,
                ),
              ),
              child: Text(
                month,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily2,
                  fontSize: 14.sp,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isSelected
                      ? AppColors.white
                      : AppColors.dark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
