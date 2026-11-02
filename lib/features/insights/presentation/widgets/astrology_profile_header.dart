import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';
import '../../domain/entities/insight_data.dart';

class AstrologyProfileHeader extends StatefulWidget {
  const AstrologyProfileHeader({
    super.key,
    required this.data,
  });

  final InsightData data;

  @override
  State<AstrologyProfileHeader> createState() => _AstrologyProfileHeaderState();
}

class _AstrologyProfileHeaderState extends State<AstrologyProfileHeader> {
  late String _selectedSign;

  static const _zodiacSigns = [
    _ZodiacSignData(
      name: 'Cancer',
      image: AppImages.cancer,
      bgColor: Color(0xFFF0F1FA),
      borderColor: Color(0xFF9FA8DA), // Soft lavender blue
      activeGlowColor: Color(0xFF7986CB),
    ),
    _ZodiacSignData(
      name: 'Virgo',
      image: AppImages.virgo,
      bgColor: Color(0xFFFFF8EC),
      borderColor: Color(0xFFD7CCC8), // Soft gold / beige
      activeGlowColor: Color(0xFFBCAAA4),
    ),
    _ZodiacSignData(
      name: 'Leo',
      image: AppImages.leo,
      bgColor: Color(0xFFFFF3E0),
      borderColor: Color(0xFFFF9E22), // Warm vibrant orange
      activeGlowColor: Color(0xFFFF9E22),
    ),
    _ZodiacSignData(
      name: 'Aries',
      image: AppImages.spine,
      bgColor: Color(0xFFFFEEEE),
      borderColor: Color(0xFFFFCDD2), // Soft coral
      activeGlowColor: Color(0xFFE57373),
    ),
    _ZodiacSignData(
      name: 'Taurus',
      image: AppImages.taurus,
      bgColor: Color(0xFFEDF7EE),
      borderColor: Color(0xFFA5D6A7), // Soft mint green
      activeGlowColor: Color(0xFF81C784),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedSign = 'Leo';
  }

  _ZodiacSignData get _currentSignData {
    return _zodiacSigns.firstWhere(
      (s) => s.name.toLowerCase() == _selectedSign.toLowerCase(),
      orElse: () => _zodiacSigns[2], // Default to Leo
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),

        // 1. User Info Header
        Text(
          widget.data.userName,
          style: TextStyle(
            fontFamily: AppTypography.fontFamily,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.dark,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          ' ${widget.data.userBirthDate}',
          style: TextStyle(
            fontFamily: AppTypography.fontFamily2,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF8E8E93),
          ),
        ),

        // Sized so that ellipse1
        SizedBox(
          width: 360.w,
          height: 340.h,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Outer concentric circles disc
              Positioned(
                top: 8.h,
                child: SizedBox(
                  width: 320.w,
                  height: 320.w,
                  child: Image.asset(
                    AppImages.ellipse1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Middle celestial wheel with constellations
              Positioned(
                top: 42.h,
                child: SizedBox(
                  width: 250.w,
                  height: 250.w,
                  child: Image.asset(
                    AppImages.ellipse2,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Inner translucent green
              Positioned(
                top: 65.h,
                child: SizedBox(
                  width: 205.w,
                  height: 205.w,
                  child: Image.asset(
                    AppImages.ellipse3,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Sun Sign (Cancer)
              Positioned(
                left: 10.w,
                top: 40.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.zodiacCancer,
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 6.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.data.sunSign,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dark,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Sun sign',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E8E93),
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Moon Sign (Leo)
              Positioned(
                right: 8.w,
                top: 40.h,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.data.moonSign,
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dark,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Moon sign',
                          style: TextStyle(
                            fontFamily: AppTypography.fontFamily2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E8E93),
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 6.w),
                    Image.asset(
                      AppImages.zodiac,
                      width: 24.w,
                      height: 24.w,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // Center Illustrated Art
              Positioned(
                top: 95.h,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: SizedBox(
                    key: ValueKey<String>(_currentSignData.name),
                    width: 135.w,
                    height: 135.w,
                    child: Image.asset(
                      _currentSignData.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // 5 Orbiting Circular Sign Buttons along the lower arc
              // 1. Cancer
              Positioned(
                left: 63.w,
                top: 168.h,
                child: _buildSignChip(_zodiacSigns[0]),
              ),

              // 2. Virgo
              Positioned(
                left: 102.w,
                top: 223.h,
                child: _buildSignChip(_zodiacSigns[1]),
              ),

              // 3. Leo
              Positioned(
                left: 154.w,
                top: 242.h,
                child: _buildSignChip(_zodiacSigns[2], isBottomCenter: true),
              ),

              // 4. Aries
              Positioned(
                left: 214.w,
                top: 223.h,
                child: _buildSignChip(_zodiacSigns[3]),
              ),

              // 5. Taurus
              Positioned(
                left: 253.w,
                top: 168.h,
                child: _buildSignChip(_zodiacSigns[4]),
              ),

              // Bottom Label
              Positioned(
                top: 304.h,
                child: Text(
                  _selectedSign,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamily2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 3. Three-dot
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.starCircle, width: 52.w, height: 17.h,)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignChip(_ZodiacSignData sign, {bool isBottomCenter = false}) {
    final isSelected = _selectedSign.toLowerCase() == sign.name.toLowerCase();
    final size = isBottomCenter
        ? (isSelected ? 54.w : 48.w)
        : (isSelected ? 48.w : 42.w);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSign = sign.name;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        padding: EdgeInsets.all(isBottomCenter ? 7.w : 6.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isBottomCenter && isSelected
              ? null
              : sign.bgColor,
          gradient: isBottomCenter && isSelected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF6E5),
                    Color(0xFFFFE6BE),
                  ],
                )
              : null,
          // CRITICAL: Each sign retains ITS OWN distinct border color!
          border: Border.all(
            color: sign.borderColor,
            width: isSelected ? 2.0.w : 1.2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? sign.activeGlowColor.withValues(alpha: 0.35)
                  : AppColors.dark.withValues(alpha: 0.06),
              blurRadius: isSelected ? 8 : 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          sign.image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _ZodiacSignData {
  final String name;
  final String image;
  final Color bgColor;
  final Color borderColor;
  final Color activeGlowColor;

  const _ZodiacSignData({
    required this.name,
    required this.image,
    required this.bgColor,
    required this.borderColor,
    required this.activeGlowColor,
  });
}
