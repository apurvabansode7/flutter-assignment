import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CelestialDivider extends StatelessWidget {
  const CelestialDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFF88BAC3),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 3.5.r,
                  height: 3.5.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D7E90),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.auto_awesome,
                  size: 14.r,
                  color: const Color(0xFF1D7E90),
                ),
                SizedBox(width: 4.w),
                Container(
                  width: 3.5.r,
                  height: 3.5.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D7E90),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF88BAC3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
