import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';

class GoalsPlaceholder extends StatelessWidget {
  const GoalsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'Goals – coming soon',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color:AppColors.dark,
            ),
          ),
        ),
      ),
    );
  }
}
