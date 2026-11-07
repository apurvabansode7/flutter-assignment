import 'package:flutter/material.dart';

/// Settings for one ring of the dial.
class DialRingConfig {
  const DialRingConfig({
    required this.label,
    required this.radiusFactor,
    required this.color,
    required this.count,
    required this.base,
    required this.labelStep,
    required this.unitsOf,
  });

  /// Text shown under the dial (Yrs, Mm, Days, Hrs, Mins, Sec).
  final String label;

  /// Ring radius as a fraction of the outer radius.
  final double radiusFactor;

  /// Fill colour of the ring band.
  final Color color;

  /// How many numbers go around one full turn.
  final int count;

  /// Number printed at slot 0 (0 for Sec, Mins, Hrs; 1 for Days, Mm; 0 for Yrs).
  final int base;

  /// Print every Nth number (e.g. 5 on Sec/Mins/Yrs, 1 on Days/Hrs/Mm).
  final int labelStep;

  /// Returns current position in units (can be fractional for smooth turns).
  final double Function(DateTime now) unitsOf;
  
}

double _localMs(DateTime t) =>
    (t.millisecondsSinceEpoch + t.timeZoneOffset.inMilliseconds).toDouble();

double _dayFraction(DateTime t) =>
    (t.hour * 3600 + t.minute * 60 + t.second + t.millisecond / 1000) / 86400;

final List<DialRingConfig> dialRingConfigs = [
  DialRingConfig(
    label: 'Yrs',
    radiusFactor: 1.00,
    color: const Color(0xFFFFF5D1),
    count: 100,
    base: 0,
    labelStep: 5,
    unitsOf: (t) => (t.year % 100) + (t.month - 1) / 12,
  ),
  DialRingConfig(
    label: 'Mm',
    radiusFactor: 0.84,
    color: const Color(0xFFF1E4B0),
    count: 12,
    base: 1,
    labelStep: 1,
    unitsOf: (t) => (t.month - 1) + (t.day - 1 + _dayFraction(t)) / 31,
  ),
  DialRingConfig(
    label: 'Days',
    radiusFactor: 0.66,
    color: const Color(0xFFD8C98F),
    count: 31,
    base: 1,
    labelStep: 1,
    unitsOf: (t) => (t.day - 1) + _dayFraction(t),
  ),
  DialRingConfig(
    label: 'Hrs',
    radiusFactor: 0.52,
    color: const Color(0xFF5E97A3),
    count: 24,
    base: 0,
    labelStep: 1,
    unitsOf: (t) => _localMs(t) / 3600000,
  ),
  DialRingConfig(
    label: 'Mins',
    radiusFactor: 0.40,
    color: const Color(0xFF8FBECA),
    count: 60,
    base: 0,
    labelStep: 5,
    unitsOf: (t) => _localMs(t) / 60000,
  ),
  DialRingConfig(
    label: 'Sec',
    radiusFactor: 0.26,
    color: const Color(0xFFABD5DF),
    count: 60,
    base: 0,
    labelStep: 5,
    unitsOf: (t) => _localMs(t) / 1000,
  ),
];
