import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/features/home/presentation/widgets/journal_notebook_cover.dart';

class BookOpeningOverlay extends StatefulWidget {
  const BookOpeningOverlay({
    super.key,
    required this.onComplete,
    this.userName = 'Saniya',
  });

  final VoidCallback onComplete;
  final String userName;

  @override
  State<BookOpeningOverlay> createState() => _BookOpeningOverlayState();
}

class _BookOpeningOverlayState extends State<BookOpeningOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _coverAngleAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _glowAnimation;
  late final Animation<double> _scrimAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _coverAngleAnimation = Tween<double>(begin: 0.0, end: -math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.76, curve: Curves.easeInOutCubic),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.12, 0.82, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _scrimAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.22, curve: Curves.easeOutCubic),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.84, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookW = 230.w;
    final bookH = bookW * (1693 / 1452);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final angle = _coverAngleAnimation.value;
        final isCoverFlipped = angle < -math.pi / 2;

        return Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: Opacity(
              opacity: _fadeAnimation.value.clamp(0.0, 1.0),
              child: Container(
                color: AppColors.dark.withValues(
                  alpha: 0.45 * _scrimAnimation.value,
                ),
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    width: bookW,
                    height: bookH,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ── 1. Inner Luminous Journal Pages (Base underneath) ──
                        RepaintBoundary(child: _buildInnerPages(bookW, bookH)),

                        // ── 2. Subtle Radiant Glow radiating from inside ──
                        if (_glowAnimation.value > 0.0)
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                gradient: RadialGradient(
                                  center: Alignment.center,
                                  radius: 0.85,
                                  colors: [
                                    const Color(0xFFB8E2E2).withValues(
                                      alpha: 0.35 * _glowAnimation.value,
                                    ),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),

                        // ── 3. Front Notebook Cover Opening in 3D ──
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(angle),
                          child: RepaintBoundary(
                            child: isCoverFlipped
                                ? Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: _buildCoverBack(bookW, bookH),
                                  )
                                : JournalNotebookCover(
                                    width: bookW,
                                    height: bookH,
                                    userName: widget.userName,
                                    isEditable: false,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoverBack(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF0D323A), Color(0xFF174B54)],
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(-5, 5),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.auto_awesome,
          size: 32.r,
          color: const Color(0xFF6EDCE8).withValues(alpha: 0.4),
        ),
      ),
    );
  }

  /// Inner lined notebook page revealed as cover opens
  Widget _buildInnerPages(double width, double height) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFEFD),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(18.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(4, 8),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2EFF0), width: 1.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inner header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MY REFLECTIONS",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColors.teal,
                  ),
                ),
                Icon(Icons.auto_awesome, size: 14.r, color: AppColors.primary),
              ],
            ),
            SizedBox(height: 12.h),

            // Delicate journal notebook ruling lines
            for (var i = 0; i < 7; i++) ...[
              Container(height: 1.h, color: const Color(0xFFE8F2F3)),
              SizedBox(height: 16.h),
            ],

            const Spacer(),

            // Star watermark at bottom
            Center(
              child: Image.asset(
                AppImages.star,
                width: 80.w,
                color: AppColors.teal.withValues(alpha: 0.3),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
