import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/features/home/presentation/widgets/circle_button.dart';
import 'package:test_app/features/home/presentation/widgets/greeting_card.dart';
import 'package:test_app/features/home/presentation/widgets/roatating_time_dial.dart';



class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.name = 'Saniya',
    this.element = 'Air  •  Mutable  •  Mercury',
  });

  final String name;
  final String element;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;

        // Header height: 1.10× width to give ample room for greeting + centered dial
        const heightRatio = 1.10;
        final h = w * heightRatio;

        // Dial radius — 85% of header width
        final dialRadius = w * 0.84;

        // Dial center: anchored at right edge (1.00*w), vertically at 0.90*h.
        // This places the active numbers (at -135°) right in the visual center
        // of the header, comfortably below the greeting and above the bottom row.
        final dialCX = w * 1.00;
        final dialCY = h * 0.90;

        // Top safe-area padding
        final topPad = MediaQuery.paddingOf(context).top;

        // ── Bottom label band height─
        const labelBandH = 32.0;

        return ClipRect(
          child: SizedBox(
            width: w,
            height: h + labelBandH,
            child: Stack(
              children: [
                //  1. Gradient background 
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.headerTop,    // 0xFF0F3B43
                          AppColors.headerBottom, // 0xFF0B2A31
                        ],
                      ),
                    ),
                  ),
                ),

                //  2. Zodiac watermark glyphs (six faint celestial glyphs) 
                _zodiac(image: AppImages.img3, left: w * 0.35, top: h * 0.13,
                    size: w * 0.085, angle: -0.20),
                _zodiac(image: AppImages.img2, left: w * 0.52, top: h * 0.14,
                    size: w * 0.115, angle:  0.25),
                _zodiac(image: AppImages.img6, left: w * 0.24, top: h * 0.35,
                    size: w * 0.090, angle: -0.15),
                _zodiac(image: AppImages.img1, left: w * 0.07, top: h * 0.41,
                    size: w * 0.100, angle: -0.35),
                _zodiac(image: AppImages.img5, left: w * 0.13, top: h * 0.53,
                    size: w * 0.110, angle: -0.25),
                _zodiac(image: AppImages.img4, left: w * 0.06, top: h * 0.67,
                    size: w * 0.080, angle:  0.10),

                //  3. Concentric time dial 
                Positioned(
                  left: dialCX - dialRadius,
                  top:  dialCY - dialRadius,
                  child: RotatingTimeDial(radius: dialRadius),
                ),

                // 4. Greeting (top-left)
                Positioned(
                  left: 20.w,
                  top: topPad + 14.h,
                  child: Greeting(name: name, element: element),
                ),

                // 5. Profile & notification buttons (top-right)
                Positioned(
                  right: 16.w,
                  top: topPad + 14.h,
                  child: const Row(
                    children: [
                      CircleIconButton(icon: Icons.person_outline),
                      SizedBox(width: 10),
                      CircleIconButton(icon: Icons.notifications_none_rounded),
                    ],
                  ),
                ),

                //  Ring-label band along the bottom 
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: labelBandH,
                  child: _DialLabelRow(
                    dialCX: dialCX,
                    dialCY: dialCY,
                    dialRadius: dialRadius,
                    headerH: h,
                    totalWidth: w,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Faint zodiac glyph helper.
  Widget _zodiac({
    required String image,
    required double left,
    required double top,
    required double size,
    required double angle,
  }) {
    return Positioned(
      left: left,
      top:  top,
      child: Transform.rotate(
        angle: angle,
        child: Image.asset(
          image,
          width: size,
          height: size,
          fit: BoxFit.contain,
          color: AppColors.white.withValues(alpha: 0.08),
        ),
      ),
    );
  }
}

// ring circle at the bottom edge of the header.

class _DialLabelRow extends StatelessWidget {
  const _DialLabelRow({
    required this.dialCX,
    required this.dialCY,
    required this.dialRadius,
    required this.headerH,
    required this.totalWidth,
  });

  final double dialCX;
  final double dialCY;
  final double dialRadius;
  final double headerH;
  final double totalWidth;

  @override
  Widget build(BuildContext context) {
    // Vertical distance from dial center to the header bottom edge
    final d = (headerH - dialCY).abs();

    return Stack(
      children: [
        for (final ring in dialRings)
          () {
            final r = ring.labelFraction * dialRadius;
            final underSqrt = r * r - d * d;

            // X intersection of this ring circle with the bottom edge line
            final labelX = underSqrt > 0
                ? dialCX - math.sqrt(underSqrt)
                : dialCX - r;

            // Clamp to visible area
            if (labelX < 0 || labelX > totalWidth) return const SizedBox.shrink();

            return Positioned(
              left: labelX - 11.w,
              width: 44.w,
              top: 6.h,
              child: Text(
                ring.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: 0.2,
                ),
              ),
            );
          }(),
      ],
    );
  }
}
