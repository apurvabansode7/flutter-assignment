import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResponsive {
  const AppResponsive._();

  static const designSize = Size(375, 812);
  static const tabletBreakpoint = 600.0;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static double height(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static bool isTablet(BuildContext context) =>
      width(context) >= tabletBreakpoint;

  static double contentMaxWidth(BuildContext context) =>
      isTablet(context) ? 720 : width(context);

  static double horizontalPadding(BuildContext context) =>
      isTablet(context) ? 32 : 16.w;

  static double widthScale(double value) => value.w;

  static double heightScale(double value) => value.h;

  static double fontSize(double value) => value.sp;

  static double radius(double value) => value.r;
}
