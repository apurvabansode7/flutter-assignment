
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key ,required this.name, required this.element});

  final String name;
  final String element;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting,
          style: AppTypography.regular12.copyWith(
            fontSize: 12.sp,
            color: AppColors.textColor3
          ),
        ),
        const SizedBox(height: 2),
        Text(
          name,
          style: AppTypography.regular12.copyWith(
            fontSize:24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textcolor1

          )
        ),
        const SizedBox(height: 4),
        Text(
          element,
          style: AppTypography.dialUnitLabel.copyWith(
            fontSize:12.sp ,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor2
          )
        ),
      ],
    );
  }
}