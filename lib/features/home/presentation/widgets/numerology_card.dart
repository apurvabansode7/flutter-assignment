import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

class NumerologyCard extends StatelessWidget {
  const NumerologyCard({
    super.key,
    this.title = 'Lucky Number',
    this.luckyNumber = 5,
     this.showLuckyNumber = false,
    this.guidanceTitle = "Today’s guidance:",
    this.guidanceText =
        'Stay open to unexpected opportunities. Trust '
        'your instincts, explore something new, and avoid '
        'overthinking your next move.',
  });

  final String title;
  final int? luckyNumber;
  final bool showLuckyNumber;
  final String guidanceTitle;
  final String guidanceText;

  // Positions are fractions of the card (x = left / width, y = top / height)
  static final List<_WatermarkNumber> _watermarks = [
    _WatermarkNumber(
      AppImages.img10,
      x: 0.166,
      y: 0.110,
      width: 0.040,
      opacity: 0.35,
    ), // 2
    _WatermarkNumber(
      AppImages.img9,
      x: 0.274,
      y: 0.163,
      width: 0.028,
      opacity: 0.30,
    ), // 1
    _WatermarkNumber(
      AppImages.img11,
      x: 0.690,
      y: 0.151,
      width: 0.075,
      opacity: 0.45,
    ), // 3
    _WatermarkNumber(
      AppImages.img16,
      x: 0.875,
      y: 0.127,
      width: 0.032,
      opacity: 0.35,
    ), // 8
    _WatermarkNumber(
      AppImages.img15,
      x: 0.078,
      y: 0.237,
      width: 0.075,
      opacity: 0.40,
    ), // 7
    _WatermarkNumber(
      AppImages.img16,
      x: 0.228,
      y: 0.320,
      width: 0.032,
      opacity: 0.35,
    ), // 8
    _WatermarkNumber(
      AppImages.img10,
      x: 0.835,
      y: 0.270,
      width: 0.035,
      opacity: 0.35,
    ), // 2
    _WatermarkNumber(
      AppImages.img9,
      x: 0.928,
      y: 0.300,
      width: 0.022,
      opacity: 0.30,
    ), // 1
    _WatermarkNumber(
      AppImages.img12,
      x: 0.108,
      y: 0.390,
      width: 0.045,
      opacity: 0.40,
    ), // 4
    _WatermarkNumber(
      AppImages.img14,
      x: 0.270,
      y: 0.460,
      width: 0.070,
      opacity: 0.40,
    ), // 6
    _WatermarkNumber(
      AppImages.img17,
      x: 0.750,
      y: 0.480,
      width: 0.065,
      opacity: 0.40,
    ), // 9
    _WatermarkNumber(
      AppImages.img13,
      x: 0.932,
      y: 0.490,
      width: 0.028,
      opacity: 0.30,
    ), // 5
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFEF8E0), Color(0xFFCBC19B)],
          stops: [0.3391, 0.923],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23.r),
        child: Stack(
          children: [
            // 1. Background numbers (1 to 9)
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;

                  return Stack(
                    children: [
                      for (final n in _watermarks)
                        Positioned(
                          left: w * n.x,
                          top: h * n.y,
                          child: Opacity(
                            opacity: n.opacity,
                            child: Image.asset(
                              n.image,
                              width: w * n.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),

            // 2. Foreground content
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTypography.regular12.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color1,
                      fontFamily: AppTypography.fontFamily2,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AppImages.img7,
                            width: 135.w,
                            height: 89.h,
                            fit: BoxFit.contain,
                          ),
                          if (luckyNumber != null && showLuckyNumber)
                            Positioned(
                              top: 22.h,
                              child: Text(
                                '$luckyNumber',
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamily,
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                  height: 1,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Image.asset(
                        AppImages.img8,
                        width: 89.w,
                        height: 84.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      guidanceTitle,
                      style: AppTypography.regular12.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.dark,
                        fontFamily: AppTypography.fontFamily2,
                      ),
                    ),
                  ),
                  SizedBox(height: 7.h),

                  Text(
                    guidanceText,
                    style: AppTypography.regular12.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.dark,
                      fontFamily: AppTypography.fontFamily2,
                      height: 1.45,
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

class _WatermarkNumber {
  const _WatermarkNumber(
    this.image, {
    required this.x,
    required this.y,
    required this.width,
    required this.opacity,
  });

  final String image;
  final double x;
  final double y;
  final double width;
  final double opacity;
}
