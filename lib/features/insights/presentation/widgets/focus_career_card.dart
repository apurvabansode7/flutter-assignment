import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';


class FocusCareerCard extends StatelessWidget {
  const FocusCareerCard({
    super.key,
    this.focusArea = 'Career',
    this.onTap,
  });

  final String focusArea;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.focusCardBgTop,
              AppColors.focusCardBgBottom,
            ],
          ),
          border: Border.all(
            color: AppColors.focusCardBorder,
            width: 1.2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF13434C).withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17.r),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // 1. Horizontal Cloud
              Positioned(
                top: 0,
                right: 85.w,
                child: Image.asset(
                  AppImages.cloud2,
                  width: 76.w,
                  height: 18.h,
                  fit: BoxFit.contain,
                ),
              ),

              // 2. Puffy Cloud
              Positioned(
                top: 0,
                right: -0.w,
                child: Image.asset(
                  AppImages.cloud1,
                  width: 44.w,
                  height: 28.h,
                  fit: BoxFit.contain,
                ),
              ),

              // 3. Background Wave Hill
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  AppImages.mountain4,
                  width: 145.w,
                  height: 24.h,
                  fit: BoxFit.fill,
                ),
              ),

              // 4. Foreground Wave Hill
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  AppImages.mountain5,
                  width: 88.w,
                  height: 20.h,
                  fit: BoxFit.fill,
                ),
              ),

              // 5. Stacked Zen Balancing Stones
              Positioned(
                right: 36.w,
                bottom: 0,
                child: Image.asset(
                  AppImages.careerStones,
                  width: 45.w,
                  height: 50.h,
                  fit: BoxFit.contain,
                ),
              ),

              // 6. Text
              Positioned(
                left: 18.w,
                top: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Focus of the day: ',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.focusCardLabel,
                          ),
                        ),
                        TextSpan(
                          text: focusArea,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.focusCardValue,
                          ),
                        ),
                      ],
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
}
