import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';
import '../../../../core/constants/app_colors.dart';


class GoalsCard extends StatelessWidget {
  const GoalsCard({
    super.key,
    this.onCreateGoal,
  });

  final VoidCallback? onCreateGoal;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 351 / 176,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(224, 224, 224, 0.92),
             AppColors.white,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(1.w), // 1px border thickness
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Sky & Warm Ivory Gradient Background
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColors.white,
                      Color(0xFFFCF9EE),
                      Color(0xFFF7EED2),
                    ],
                    stops: [0.35, 0.75, 1.0],
                  ),
                ),
              ),

              // 2. Mountain Layer 3
              Positioned(
                left: 0,
                bottom: 0,
                width: 351.w,
                height: 105.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountain3,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 3. Mountain Layer 1
              Positioned(
                right: 0,
                top: 34.h,
                width: 275.w,
                height: 105.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountain1,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 4. Flag at Mountain Peak
              Positioned(
                right: 120.w,
                top: 9.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.flag,
                    fit: BoxFit.contain,
                    width: 22.w,
                    height: 27.h,
                  ),
                ),
              ),

              // 5. Mountain Layer 2
              Positioned(
                right: 0,
                bottom: 45.h,
                width: 185.w,
                height: 75.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountain2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 6. Center Dramatic Cliff
              Positioned(
                right: 0,
                bottom: 0,
                width: 215.w,
                height: 115.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountainCliff,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 7. Turquoise Left Slope
              Positioned(
                left: 0,
                bottom: 0,
                width: 225.w,
                height: 75.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountainRidge,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 8. Foreground Wave Overlays
              Positioned(
                left: 0,
                bottom: 0,
                width: 175.w,
                height: 32.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountain4,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                width: 145.w,
                height: 32.h,
                child: IgnorePointer(
                  child: Image.asset(
                    AppImages.mountain5,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // 9. Card Header Content
              Positioned(
                top: 15.h,
                left: 21.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No Goals Yet',
                      style: AppTypography.goalCardTitle.copyWith(
                        fontSize: 19.sp,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 160.w,
                      child: Text(
                        'Let your intentions guide\nyour journey.',
                        style: AppTypography.goalCardSubtitle.copyWith(
                          fontSize: 13.sp,
                          height: 1.25,
                          color: const Color(0xFF6E6E73),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 10. Bottom Button
              Positioned(
                left: 40.w,
                right: 40.w,
                bottom: 16.h,
                height: 36.h,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    side: BorderSide(
                      color: AppColors.white,
                      width: 1.2.w,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: onCreateGoal ??
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Create Goal action clicked!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Create Your Goal',
                            style: AppTypography.goalCardButtonText.copyWith(
                              fontSize: 13.5.sp,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
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
