import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';
import '../../domain/entities/journal_entry.dart';

class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({
    super.key,
    required this.entry,
    this.onTap,
    this.onDelete,
  });

  final JournalEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final weekday = DateFormat('EEE').format(entry.date);

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.journalEntryBorderTop,    // #F4F4F4 0%
            AppColors.journalEntryBorderBottom, // #B8E2E2 100%
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF13434C).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(1.w), // 1px border width
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.journalEntryBgTop,    // #FFFFFF 0%
              AppColors.journalEntryBgBottom, // #ECF6F6 100%
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(23.r),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.w, 16.h, 16.w, 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Column
                  SizedBox(
                    width: 52.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          entry.date.day.toString(),
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teal,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          entry.month,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          weekday,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6E6E73),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 14.w),

                  // Vertical Divider
                  Container(
                    width: 1.w,
                    height: 64.h,
                    color: const Color(0xFFDCE6E8),
                  ),

                  SizedBox(width: 14.w),

                  // Content Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily2,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 22.r,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          entry.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          entry.time,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6E6E73),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
