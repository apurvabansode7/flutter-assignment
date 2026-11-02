import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

class DestinyCard extends StatelessWidget {
  const DestinyCard({
    super.key,
    this.destinyNumber = 7,
    this.destinyTitle = 'The Seeker',
    this.onTap,
  });

  final int destinyNumber;
  final String destinyTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AspectRatio(
        aspectRatio: 1608 / 1400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23.r),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;
        
              final sunSize = w * 0.275;
        
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // 1. Base White Background
                  const Positioned.fill(
                    child: ColoredBox(color: AppColors.white),
                  ),
        
                  // 2. Glowing Sun Circle with Dynamic Destiny Number
                  Positioned(
                    top: h * 0.18,
                    left: (w - sunSize) / 2,
                    width: sunSize,
                    height: sunSize,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFDF0CD),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFF9E5).withValues(alpha: 0.9),
                            blurRadius: 36,
                            spreadRadius: 16,
                          ),
                          BoxShadow(
                            color: const Color(0xFFFEF3C7).withValues(alpha: 0.65),
                            blurRadius: 18,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      alignment: const Alignment(0, -0.12),
                      child: Text(
                        '$destinyNumber',
                        style: AppTypography.destinyCardNumber.copyWith(
                          fontSize: 38.sp,
                        ),
                      ),
                    ),
                  ),
        
                  // 3. Winding Path
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: h * 0.58,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.path,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
        
                  // 4. Left Tree with Ground Line
                  Positioned(
                    left: 0,
                    top: h * 0.11,
                    width: 148.w,
                    height: 126.h,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.tree,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  ),
        
                  // 5. Right Tree with Ground Line
                  Positioned(
                    right: 0,
                    top: h * 0.11,
                    width: 148.w,
                    height: 126.h,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.tree2,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
        
                  // 6. Silhouette of Man Standing on Path
                  Positioned(
                    left: (w - 33.w) / 2,
                    top: h * 0.42,
                    width: 33.w,
                    height: 114.h,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.man,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
        
                  // 7. Dynamic Destiny Text Block
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 6.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Destiny Number $destinyNumber',
                          textAlign: TextAlign.center,
                          style: AppTypography.destinyCardTitle.copyWith(
                            fontSize: 16.sp,
                            fontFamily: AppTypography.fontFamily2
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          destinyTitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.destinyCardSubtitle.copyWith(
                            fontSize: 14.sp,
                            fontFamily: AppTypography.fontFamily2
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
