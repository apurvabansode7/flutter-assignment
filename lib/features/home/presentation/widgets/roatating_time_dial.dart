import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/core/constants/app_colors.dart';

// Constants 

/// The angle at which the active slot is pinned (upper-left diagonal, -135° = -3π/4).
const double _kPointerAngle = -3 * math.pi / 4;

/// Angular distance between consecutive numbers (12.0° = ~0.2094 rad).
/// Shared across ALL 6 rings so all numbers align on identical radial rays
/// while providing clean, comfortable spacing for two-digit seconds (e.g. 23, 24).
const double _kStepAngle = 12.0 * math.pi / 180;

/// Number of slots visible to the left and right of the active center number.
/// Exactly 3 on the left, 1 in the centre, 3 on the right = 7 numbers total.
const int _kVisibleWindow = 3;


class DialRing {
  const DialRing({
    required this.label,
    required this.outerFraction,
    required this.labelFraction,
    required this.bandColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeFontSize,
    required this.inactiveFontSize,
    required this.getValue,
  });

  final String label;
  final double outerFraction;
  final double labelFraction;
  final Color bandColor;
  final Color activeColor;
  final Color inactiveColor;
  final double activeFontSize;
  final double inactiveFontSize;
  final int Function(DateTime now) getValue;
}

//  6 Concentric Rings (Outer to Inner) 
// Precise Figma specs:
//   • Year dial: 36px selected, 28px unselected
//   • Seconds dial: 16px selected, 13px unselected
//   • Proportional scaling for Mm, Days, Hrs, Mins

final List<DialRing> dialRings = [
  // 1. Yrs – outermost, cream-white
  DialRing(
    label: 'Yrs',
    outerFraction: 1.000,
    labelFraction: 0.915,
    bandColor: AppColors.yrsColor,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor: AppColors.inactiveColor,
    activeFontSize: 36,   // Figma selected: 36px
    inactiveFontSize: 28, // Figma unselected: 28px
    getValue: (t) => t.year % 100,
  ),

  // 2. Mm – warm yellow
  DialRing(
    label: 'Mm',
    outerFraction: 0.835,
    labelFraction: 0.755,
    bandColor: AppColors.monthColor,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor: AppColors.inactiveColor,
    activeFontSize: 32,
    inactiveFontSize: 25,
    getValue: (t) => t.month,
  ),

  // 3. Days – warm tan
  DialRing(
    label: 'Days',
    outerFraction: 0.670,
    labelFraction: 0.585,
    bandColor: AppColors.dayColor,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor: AppColors.inactiveColor,
    activeFontSize: 28,
    inactiveFontSize: 22,
    getValue: (t) => t.day,
  ),

  // 4. Hrs – deep saturated teal
  DialRing(
    label: 'Hrs',
    outerFraction: 0.520,
    labelFraction: 0.445,
    bandColor: AppColors.hourColor,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor: AppColors.inactiveColor,
    activeFontSize: 24,
    inactiveFontSize: 19,
    getValue: (t) => t.hour,
  ),

  // 5. Mins – mid teal
  DialRing(
    label: 'Mins',
    outerFraction: 0.380,
    labelFraction: 0.310,
    bandColor: AppColors.minsColor,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor: AppColors.minsColorInactive,
    activeFontSize: 20,
    inactiveFontSize: 16,
    getValue: (t) => t.minute,
  ),

  // 6. Sec – innermost pale teal
  DialRing(
    label: 'Sec',
    outerFraction: 0.250,
    labelFraction: 0.200,
    bandColor: AppColors.secColors,
    activeColor: AppColors.numerologyGuidanceTitle,
    inactiveColor:AppColors.secColorInactive,
    activeFontSize: 13.5, // Crisp 2-digit clarity without colliding
    inactiveFontSize: 10.5, // Scaled for breathing room between 2-digit seconds
    getValue: (t) => t.second,
  ),
];



// RotatingTimeDial Widget 

class RotatingTimeDial extends StatefulWidget {
  const RotatingTimeDial({super.key, required this.radius});

  /// Outer radius in logical pixels.
  final double radius;

  @override
  State<RotatingTimeDial> createState() => _RotatingTimeDialState();
}

class _RotatingTimeDialState extends State<RotatingTimeDial> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.radius;
    final d = r * 2;

    return SizedBox(
      width: d,
      height: d,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Filled concentric ring bands 
          for (final ring in dialRings)
            _RingBand(
              outerRadius: r * ring.outerFraction,
              color: ring.bandColor,
              totalRadius: r,
            ),

          // 2. Numbers on each ring, aligned on radial rays
          // Exactly 7 numbers per dial: 3 left, 1 centre (selected), 3 right
          for (final ring in dialRings)
            _RingRayNumbers(
              ring: ring,
              radius: r,
              activeValue: ring.getValue(_now),
            ),
        ],
      ),
    );
  }
}

// _RingBand 

class _RingBand extends StatelessWidget {
  const _RingBand({
    required this.outerRadius,
    required this.color,
    required this.totalRadius,
  });

  final double outerRadius;
  final Color color;
  final double totalRadius;

  @override
  Widget build(BuildContext context) {
    final size = outerRadius * 2;
    final offset = totalRadius - outerRadius;

    return Positioned(
      left: offset,
      top: offset,
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ─── _RingRayNumbers 
// Renders exactly 7 numbers on each ring:
//   • 3 numbers on the left  (k = -3, -2, -1)
//   • 1 centre number        (k = 0, selected, bold)
//   • 3 numbers on the right (k = 1, 2, 3)
// All numbers align along the shared radial rays at _kPointerAngle + k * _kStepAngle.

class _RingRayNumbers extends StatelessWidget {
  const _RingRayNumbers({
    required this.ring,
    required this.radius,
    required this.activeValue,
  });

  final DialRing ring;
  final double radius;
  final int activeValue;

  @override
  Widget build(BuildContext context) {
    final ringR = radius * ring.labelFraction;
    final center = radius;

    final widgets = <Widget>[];

    for (var k = -_kVisibleWindow; k <= _kVisibleWindow; k++) {
      final isActive = (k == 0);
      final rawNumber = activeValue + k;

      // Clean cyclic wrap-around for time dials
      final int number;
      if (ring.label == 'Sec' || ring.label == 'Mins') {
        number = (rawNumber % 60 + 60) % 60;
      } else if (ring.label == 'Hrs') {
        number = (rawNumber % 24 + 24) % 24;
      } else if (ring.label == 'Days') {
        number = ((rawNumber - 1) % 31 + 31) % 31 + 1;
      } else if (ring.label == 'Mm') {
        number = ((rawNumber - 1) % 12 + 12) % 12 + 1;
      } else {
        number = rawNumber; // Yrs
      }

      final displayString = '$number';

      // Angle of this number relative to dial center
      final angle = _kPointerAngle + k * _kStepAngle;

      // Position of this number's box
      final cx = center + ringR * math.cos(angle);
      final cy = center + ringR * math.sin(angle);

      final fontSize = isActive ? ring.activeFontSize : ring.inactiveFontSize;
      final fontColor = isActive ? ring.activeColor : ring.inactiveColor;
      final letterSpacing = ring.label == 'Sec'
          ? -0.04 * fontSize
          : -0.02 * fontSize;

      // Responsive box half-size so numbers never clip
      final boxHalf = ring.label == 'Sec'
          ? (isActive ? 16.0 : 12.0)
          : (isActive ? 30.0 : 22.0);

      widgets.add(
        Positioned(
          left: cx - boxHalf,
          top: cy - boxHalf,
          width: boxHalf * 2,
          height: boxHalf * 2,
          child: Center(
            child: Transform.rotate(
              // Rotates number tangent to the circle arc
              angle: angle + math.pi / 2,
              child: Text(
                displayString,
                textAlign: TextAlign.center,
                style: GoogleFonts.agdasima(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: fontColor,
                  letterSpacing: letterSpacing,
                  height: 1.29,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: widgets,
    );
  }
}
