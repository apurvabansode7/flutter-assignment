import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/constants/app_colors.dart';

class AppTypography {
  const AppTypography._();

  static const fontFamily = 'Geist';
  static const fontFamily2 = 'Satoshi';
  static const fontFamily3 = 'Poppins';

  static const regular12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  // Section Title on Home Screen
  static const sectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF8E8E93),
    height: 1.29,
    letterSpacing: -0.02 * 16, // -2% letter spacing
    leadingDistribution: TextLeadingDistribution.even,
  );

  // Horoscope Card Title
  static const horoscopeTitle = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // Horoscope Card Date
  static const horoscopeDate = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.horoscopeDate,
  );

  // Horoscope Card Body
  static const horoscopeBody = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    height: 1.38,
    letterSpacing: -0.02 * 14, // -2% letter spacing
    leadingDistribution: TextLeadingDistribution.even,
  );

  // Horoscope Card Read More
  static TextStyle horoscopeReadMore({
    double? fontSize,
    Color color = AppColors.text,
  }) =>
      GoogleFonts.poppins(
        fontSize: fontSize ?? 12,
        fontWeight: FontWeight.w500,
        color: color,
        height: 1.40,
        letterSpacing: -0.01 * (fontSize ?? 12), // -1% letter spacing
      );

  // Bottom unit labels
  static const dialUnitLabel = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    height: 1,
  );

  // Unselected numbers around the dial
  static const dialNumber = TextStyle(
    fontFamily: 'Agdasima',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: Color(0xFFB8B5A5),
    height: 1,
  );

  // Selected number at the pointer
  static const dialActiveNumber = TextStyle(
    fontFamily: 'Agdasima',
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Color(0xFF111111),
    height: 1,
  );

  // Insights Today's Horoscope Card
  static const insightsHoroscopeTitle = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    height: 22 / 16,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const insightsHoroscopeBody = TextStyle(
    fontFamily: fontFamily2,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF333333),
    height: 22 / 12,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // Goals Card Typography
  static const goalCardTitle = TextStyle(
    fontFamily: fontFamily, // Geist
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    height: 1.29,
    letterSpacing: -0.02 * 20,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const goalCardSubtitle = TextStyle(
    fontFamily: fontFamily2, // Satoshi
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF555555),
    height: 1.29,
    letterSpacing: -0.02 * 14,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const goalCardButtonText = TextStyle(
    fontFamily: fontFamily, // Geist
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.29,
    letterSpacing: -0.02 * 14,
    leadingDistribution: TextLeadingDistribution.even,
  );

  // Destiny Card Typography
  static const destinyCardNumber = TextStyle(
    fontFamily: fontFamily2, // Satoshi
    fontSize: 41,
    fontWeight: FontWeight.w700,
    color: Color(0xFF5D584A),
    height: 1,
  );

  static const destinyCardTitle = TextStyle(
    fontFamily: fontFamily, // Geist
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
    letterSpacing: -0.3,
  );

  static const destinyCardSubtitle = TextStyle(
    fontFamily: fontFamily2, // Satoshi
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.color1,
    letterSpacing: 0.1,
  );
}
