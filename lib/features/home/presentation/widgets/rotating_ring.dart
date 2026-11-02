import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_responsive.dart';
import 'package:test_app/features/home/presentation/widgets/dialg_ring.dart';

const double _pointerTurns = -0.125; // pointer at upper-left
const double _labelBox = 28;

class RotatingRing extends StatelessWidget {
  const RotatingRing({
    super.key,
    required this.config,
    required this.diameter,
    required this.now,
  });

  final DialRingConfig config;
  final double diameter;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final units = config.unitsOf(now);
    final currentIndex = units.floor() % config.count;
    final center = diameter / 2;
    final radius = (diameter / 2) * config.radiusFactor;

    return AnimatedRotation(
      turns: _pointerTurns - (units / config.count),
      duration: const Duration(milliseconds: 900),
      curve: Curves.linear,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < config.count; i++)
            if (i % config.labelStep == 0 || i == currentIndex)
              _buildSlot(
                center: center,
                radius: radius,
                index: i,
                isCurrent: i == currentIndex,
              ),
        ],
      ),
    );
  }

  Widget _buildSlot({
    required double center,
    required double radius,
    required int index,
    required bool isCurrent,
  }) {
    final angle = (2 * math.pi / config.count) * index;
    final x = center + radius * math.cos(angle) - _labelBox / 2;
    final y = center + radius * math.sin(angle) - _labelBox / 2;

    return Positioned(
      left: x,
      top: y,
      width: _labelBox,
      height: _labelBox,
      child: Center(
        child: Transform.rotate(
          angle: angle + math.pi / 2,
          child: Text(
            '${config.base + index}',
            style: TextStyle(
              fontSize: isCurrent
                  ? AppResponsive.fontSize(22)
                  : AppResponsive.fontSize(12),
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
              color: isCurrent
                  ? const Color(0xFF141414)
                  : const Color(0xFF8E8E93),
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
