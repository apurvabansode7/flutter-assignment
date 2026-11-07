import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';

class JournalMonthFilter extends StatefulWidget {
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
  State<JournalMonthFilter> createState() => _JournalMonthFilterState();
}

class _JournalMonthFilterState extends State<JournalMonthFilter> {
  ScrollController? _scrollController;

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const monthWidth = 110.0;
        const monthGap = 8.0;
        final selectedIndex = widget.months.indexWhere(
          (month) => month.toLowerCase() == widget.selectedMonth.toLowerCase(),
        );
        final itemWidth = monthWidth.w;
        final itemStride = (monthWidth + monthGap).w;
        final maxScrollOffset =
            (itemStride * widget.months.length - constraints.maxWidth).clamp(
              0.0,
              double.infinity,
            );
        final selectedOffset = selectedIndex < 0
            ? 0.0
            : (selectedIndex * itemStride -
                      (constraints.maxWidth - itemWidth) / 2)
                  .clamp(0.0, maxScrollOffset);
        _scrollController ??= ScrollController(
          initialScrollOffset: selectedOffset,
        );

        return SizedBox(
          height: 38.h,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.months.length,
            separatorBuilder: (_, _) => SizedBox(width: monthGap.w),
            itemBuilder: (context, index) {
              final month = widget.months[index];
              final isSelected =
                  month.toLowerCase() == widget.selectedMonth.toLowerCase();

              return GestureDetector(
                onTap: () => widget.onMonthSelected(month),
                child: Container(
                  width: itemWidth,
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
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 16.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected ? AppColors.white : AppColors.dark,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
