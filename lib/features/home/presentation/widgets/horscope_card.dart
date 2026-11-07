import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

class HoroscopeCard extends StatelessWidget {
  const HoroscopeCard({
    super.key,
    this.title = 'Gemini',
    this.date = '13 August 2026',
    this.description =
        'Your natural curiosity is your strength today. '
        'Stay open to new ideas, but give yourself time '
        'to focus before making decisions.',
    this.showSectionHeader = true,
    this.onReadMore,
  });

  final String title;
  final String date;
  final String description;
  final bool showSectionHeader;
  final VoidCallback? onReadMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. The Main Horoscope Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.horoscopeCardBackground,
                AppColors.horoscopeMiddle,
                AppColors.horoscopeEnd,
              ],
              stops: [0.0, 0.45, 1.0],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Subtle celestial spotlight beam shining from behind the coin
              Positioned(
                right: 15.w,
                top: 0,
                width: 150.w,
                height: 180.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.4, -0.6),
                      radius: 0.85,
                      colors: [
                        AppColors.horoscopeGlow.withValues(alpha: 0.24),
                        AppColors.horoscopeGlow.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Twinkling cosmic stars matching design positions
              Positioned(
                right: 180.w,
                top: 24.h,
                child: _buildStar(2.5.w, opacity: 0.9),
              ),
              Positioned(
                right: 172.w,
                top: 52.h,
                child: _buildStar(2.0.w, opacity: 0.75),
              ),
              Positioned(
                right: 135.w,
                top: 78.h,
                child: _buildStar(2.2.w, opacity: 0.8),
              ),
              Positioned(
                right: 28.w,
                top: 48.h,
                child: _buildStar(2.0.w, opacity: 0.7),
              ),
              Positioned(
                right: 26.w,
                top: 105.h,
                child: _buildStar(2.0.w, opacity: 0.8),
              ),
              Positioned(
                right: 145.w,
                top: 130.h,
                child: _buildStar(2.2.w, opacity: 0.85),
              ),
              Positioned(
                right: 86.w,
                top: 122.h,
                child: _buildStar(2.5.w, opacity: 0.9),
              ),
              Positioned(
                right: 78.w,
                top: 155.h,
                child: _buildStar(1.8.w, opacity: 0.7),
              ),

              // Card Text Content
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 22.h, 20.w, 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sign Title
                    Text(
                      title,
                      style: AppTypography.horoscopeTitle.copyWith(
                        fontSize: 19.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // Date
                    Text(
                      date,
                      style: AppTypography.horoscopeDate.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Body Paragraph
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: Text(
                        description,
                        style: AppTypography.horoscopeBody.copyWith(
                          fontSize: 13.5.sp,
                          height: 1.35,
                          letterSpacing: -0.02 * 13.5.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Read More button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onReadMore,
                        child: Text(
                          'Read more  ›',
                          style: AppTypography.horoscopeReadMore(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Golden Zodiac Coin Medallion 
              Positioned(
                right: 24.w,
                top: -26.h,
                child: Image.asset(
                  AppImages.sign,
                  width: 84.w,
                  height: 84.h,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Container(
                    width: 88.w,
                    height: 88.h,
                    decoration: const BoxDecoration(
                      color: AppColors.horoscopeCoinFallback,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Small glowing circular cosmos star
  Widget _buildStar(double size, {double opacity = 0.9}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: opacity),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.horoscopeStar.withValues(alpha: 0.6 * opacity),
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ],
      ),
    );
  }
}
