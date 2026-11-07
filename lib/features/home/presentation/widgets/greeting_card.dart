// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:test_app/core/constants/app_colors.dart';
// import 'package:test_app/core/constants/app_typography.dart';

// class Greeting extends StatelessWidget {
//   const Greeting({super.key, required this.name, required this.element});

//   final String name;
//   final String element;

//   String get _greeting {
//     final hour = DateTime.now().hour;
//     if (hour < 12) return 'Good Morning,';
//     if (hour < 17) return 'Good Afternoon,';
//     return 'Good Evening,';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           _greeting,
//           style: TextStyle(
//             fontFamily: AppTypography.fontFamily2,
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             color: const Color(0xFFC0D5D8),
//             height: 1.2,
//           ),
//         ),
//         SizedBox(height: 3.h),
//         Text(
//           name,
//           style: TextStyle(
//             fontFamily: AppTypography.fontFamily,
//             fontSize: 24.sp,
//             fontWeight: FontWeight.w700,
//             color: AppColors.white,
//             height: 1.2,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         Text(
//           element,
//           style: TextStyle(
//             fontFamily: AppTypography.fontFamily2,
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFF7DD4E0),
//             letterSpacing: 0.2,
//             height: 1.2,
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    super.key,
    required this.name,
    required this.element,
  });

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
    final width = MediaQuery.sizeOf(context).width;
    final scale = width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _greeting,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily2,
            fontSize: 12 * scale,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFC0D5D8),
            height: 1.2,
          ),
        ),

        SizedBox(height: 3 * scale),

        Text(
          name,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 24 * scale,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            height: 1.2,
          ),
        ),

        SizedBox(height: 5 * scale),

        Text(
          element,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily2,
            fontSize: 12 * scale,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF7DD4E0),
            letterSpacing: 0.2 * scale,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
