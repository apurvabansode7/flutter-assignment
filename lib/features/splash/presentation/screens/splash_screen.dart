
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';
import 'package:test_app/features/home/presentation/screens/main_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainHomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF041317),
              Color(0xFF092930),
              Color(0xFF0F3B43),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // App Logo / Name
                  Text(
                    'ASTRO',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 9.w,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Decorative Star Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 45.w,
                        height: 1.h,
                        color: AppColors.secColor,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Icon(
                          Icons.auto_awesome,
                          color: AppColors.cream,
                          size: 18.sp,
                        ),
                      ),

                      Container(
                        width: 45.w,
                        height: 1.h,
                        color: AppColors.secColor,
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Tagline
                  Text(
                    'ALIGN WITH YOUR STARS',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily2,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.w,
                      color: const Color(0xFFBCE3E8),
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
