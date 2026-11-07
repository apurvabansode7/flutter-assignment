import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';


class DirectionAndColourSection extends StatelessWidget {
  const DirectionAndColourSection({
    super.key,
    required this.direction,
    required this.colour,
  });

  final String direction;
  final String colour;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Favourable Direction Column
        Expanded(
          child: _AttributeCardItem(
            title: 'Favourable Direction',
            imagePath: AppImages.direction,
            imageWidth: 99.w,
            imageHeight: 116.h,
            value: direction,
          ),
        ),

        SizedBox(width: 14.w),

        // Lucky Colour Column
        Expanded(
          child: _AttributeCardItem(
            title: 'Lucky Colour',
            imagePath: AppImages.flower,
            imageWidth: 66.w,
            imageHeight: 76.h,
            value: colour,
          ),
        ),
      ],
    );
  }
}

class _AttributeCardItem extends StatelessWidget {
  const _AttributeCardItem({
    required this.title,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    required this.value,
  });

  final String title;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section Title
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily2,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
        ),

        SizedBox(height: 14.h),

        // Center Illustration zone
        SizedBox(
          height: 100.h,
          child: Center(
            child: Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 14.h),

        // Value Badge with decorative wings
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.right,
                width: 38.w,
                height: 5.h,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1B7F8C),
                  ),
                ),
              ),
              Image.asset(
                AppImages.left,
                width: 38.w,
                height: 5.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
