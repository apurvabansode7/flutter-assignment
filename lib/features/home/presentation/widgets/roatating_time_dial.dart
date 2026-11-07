import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
// Calibrated to exact Figma reference and scaled responsively with .sp:
//   • Selected numbers: bold, dark, prominent
//   • Unselected numbers: scaled down and subtly colored for breathing room

final List<DialRing> dialRings = [
  // 1. Yrs – outermost, cream-white
  DialRing(
    label: 'Yrs',
    outerFraction: 1.000,
    labelFraction: 0.915,
    bandColor: AppColors.yrsColor,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFFBEBBAB),
    activeFontSize: 28,
    inactiveFontSize: 18,
    getValue: (t) => t.year % 100,
  ),

  // 2. Mm – warm yellow
  DialRing(
    label: 'Mm',
    outerFraction: 0.835,
    labelFraction: 0.755,
    bandColor: AppColors.monthColor,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFFB8AF85),
    activeFontSize: 26,
    inactiveFontSize: 16,
    getValue: (t) => t.month,
  ),

  // 3. Days – warm tan
  DialRing(
    label: 'Days',
    outerFraction: 0.670,
    labelFraction: 0.585,
    bandColor: AppColors.dayColor,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFFA3966D),
    activeFontSize: 23,
    inactiveFontSize: 15,
    getValue: (t) => t.day,
  ),

  // 4. Hrs – deep saturated teal
  DialRing(
    label: 'Hrs',
    outerFraction: 0.520,
    labelFraction: 0.445,
    bandColor: AppColors.hourColor,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFF2C5E68),
    activeFontSize: 20,
    inactiveFontSize: 13,
    getValue: (t) => t.hour,
  ),

  // 5. Mins – mid teal
  DialRing(
    label: 'Mins',
    outerFraction: 0.380,
    labelFraction: 0.310,
    bandColor: AppColors.minsColor,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFF3B7A87),
    activeFontSize: 17,
    inactiveFontSize: 11,
    getValue: (t) => t.minute,
  ),

  // 6. Sec – innermost pale teal
  DialRing(
    label: 'Sec',
    outerFraction: 0.250,
    labelFraction: 0.200,
    bandColor: AppColors.secColors,
    activeColor: const Color(0xFF141414),
    inactiveColor: const Color(0xFF5A8A96),
    activeFontSize: 14,
    inactiveFontSize: 9.5,
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

class _RotatingTimeDialState extends State<RotatingTimeDial>
    with SingleTickerProviderStateMixin {
  late DateTime _now;
  Timer? _timer;
  late final AnimationController _animController;
  late final Animation<double> _easeAnimation;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _easeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _animController.forward(from: 1.0);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
        _animController.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
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

          // 2. Numbers on each ring, aligned on radial rays with smooth transitions
          for (final ring in dialRings)
            AnimatedBuilder(
              animation: _easeAnimation,
              builder: (context, _) {
                final animProgress = ring.label == 'Sec' ? _easeAnimation.value : 1.0;
                return _RingRayNumbers(
                  ring: ring,
                  radius: r,
                  activeValue: ring.getValue(_now),
                  animationProgress: animProgress,
                );
              },
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
    this.animationProgress = 1.0,
  });

  final DialRing ring;
  final double radius;
  final int activeValue;
  final double animationProgress;

  @override
  Widget build(BuildContext context) {
    final ringR = radius * ring.labelFraction;
    final center = radius;

    final widgets = <Widget>[];

    // Sub-step angle offset for silky smooth gliding transitions
    final angleOffset = (1.0 - animationProgress) * _kStepAngle;

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

      // Angle of this number relative to dial center with smooth motion
      final angle = _kPointerAngle + k * _kStepAngle + angleOffset;

      // Position of this number's box
      final cx = center + ringR * math.cos(angle);
      final cy = center + ringR * math.sin(angle);

      //final fontSize = (isActive ? ring.activeFontSize : ring.inactiveFontSize).sp;
      final fontSize = (isActive
    ? ring.activeFontSize
    : ring.inactiveFontSize).sp;
      final fontColor = isActive ? ring.activeColor : ring.inactiveColor;
      final letterSpacing = -0.02 * fontSize;

      // Responsive box half-size so numbers never clip on any display
      // final boxHalf = ring.label == 'Sec'
      //     ? (isActive ? 16.0.r : 12.0.r)
      //     : (isActive ? 26.0.r : 18.0.r);
      final boxHalf = ring.label == 'Sec'
    ? (isActive ? 16.0.r : 12.0.r)
    : (isActive ? 26.0.r : 18.0.r);

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
                  height: 1.15,
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
