import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

import '../../../../core/constants/app_colors.dart';


class FunFactsCard extends StatelessWidget {
  const FunFactsCard({
    super.key,
    this.title = 'Fun Facts',
    this.description =
        'Leo is ruled by the Sun ☀️, which is why it’s traditionally associated with confidence, creativity, warmth, and a natural desire to shine.',
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
          minHeight: height ?? 148.h,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.headerBottom.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 1. Organic Wavy Parchment Container Background
            Positioned.fill(
              child: Image.asset(
                AppImages.container,
                fit: BoxFit.fill,
              ),
            ),

            // 2. Soft Puffy Cloud 1
            Positioned(
              top: -6.h,
              right: -8.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.cloud4,
                  width: 80.w,
                  height: 46.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 3. Soft Puffy Cloud 2
            Positioned(
              bottom: -8.h,
              left: -10.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.cloud5,
                  width: 120.w,
                  height: 70.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 4. Subtle 4-point Sparkle Star near bottom-left
            Positioned(
              bottom: 12.h,
              left: 65.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.star,
                  width: 10.w,
                  height: 10.h,
                  color: AppColors.headerTop.withValues(alpha: 0.5),
                ),
              ),
            ),

            // 5. Stylized Line Cloud
            Positioned(
              top: 10.h,
              right: 110.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.cloud3,
                  width: 64.w,
                  height: 36.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 6. Stylized Line Cloud
            Positioned(
              bottom: 12.h,
              left: 45.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.cloud3,
                  width: 62.w,
                  height: 34.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 7. Stylized Line Cloud
            Positioned(
              bottom: 10.h,
              right: 22.w,
              child: IgnorePointer(
                child: Image.asset(
                  AppImages.cloud3,
                  width: 66.w,
                  height: 37.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 8. Foreground Content
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 18.h, 24.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      height: 1.5,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
