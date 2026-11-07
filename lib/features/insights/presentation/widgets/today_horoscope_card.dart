import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';


class TodayHoroscopeCard extends StatelessWidget {
  const TodayHoroscopeCard({
    super.key,
    this.title = 'Your today’s horoscope',
    this.description =
        'Give yourself time to heal and focus on your well-being today. Avoid unhealthy habits and choose nourishing foods. Stay patient—positive career opportunities are on the way, while love brings warmth and connection.',
    this.width,
    this.height,
    this.onTap,
  });

  final String title;
  final String description;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width ?? double.infinity,
        constraints: BoxConstraints(
          minHeight: height ?? 168.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.horoscopeInsightBg,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: const Color(0xFFF3EAC2),
            width: 1.2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF141414).withValues(alpha: 0.02),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21.r),
          child: Stack(
            children: [
              // Celestial Wheel Watermark in Bottom-Right
              Positioned(
                right: -5.w,
                bottom: -6.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.ellipse4,
                    width: 185.w,
                    height: 147.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Content: Title & Description
              Padding(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTypography.insightsHoroscopeTitle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      description,
                      style: AppTypography.insightsHoroscopeBody.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
