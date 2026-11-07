import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_typography.dart';

import 'journal_notebook_cover.dart';

class JournalCard extends StatefulWidget {
  const JournalCard({
    super.key,
    this.userName = 'Saniya',
    this.signName = 'Libra',
    this.signGlyph,
    this.width,
    this.height,
    this.isEditable = true,
    this.onTap,
    this.onNameChanged,
    this.autoNavigateDelay,
    this.openOnLoad = false,
  });

  final String userName;
  final String signName;
  final String? signGlyph;
  final double? width;
  final double? height;
  final bool isEditable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onNameChanged;
  final Duration? autoNavigateDelay;
  final bool openOnLoad;

  @override
  JournalCardState createState() => JournalCardState();
}

class JournalCardState extends State<JournalCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _coverSlideAnimation;
  late final Animation<Offset> _pageSlideAnimation;

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    // Cover slides out to the left (side-by-side transition)
    _coverSlideAnimation =
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.05, 0.0),
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );

    // Opened page slides in from the right side-by-side
    _pageSlideAnimation =
        Tween<Offset>(begin: const Offset(1.05, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isOpen = true);
        if (widget.autoNavigateDelay != null) {
          Future.delayed(widget.autoNavigateDelay!, () {
            if (mounted && _controller.status == AnimationStatus.completed) {
              widget.onTap?.call();
            }
          });
        }
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _isOpen = false);
      }
    });

    if (widget.openOnLoad) {
      _controller.forward();
    }
  }

  void _toggle() {
    if (_controller.isAnimating) return;
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void close() {
    if (_controller.status != AnimationStatus.dismissed) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AspectRatio(
        aspectRatio: 1452 / 1693,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.withValues(alpha: 0.12),
                blurRadius: 22,
                offset: const Offset(4, 10),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── 1. Pure Flutter Opened Journal Card (Slides in from the right) ──
              SlideTransition(
                position: _pageSlideAnimation,
                child: OpenedJournalCard(
                  onWriteEntry: () => widget.onTap?.call(),
                  onTapPage: _toggle,
                ),
              ),

              // ── 2. Closed Notebook Cover (Slides out to the left) ──
              SlideTransition(
                position: _coverSlideAnimation,
                child: GestureDetector(
                  onTap: _toggle,
                  behavior: HitTestBehavior.opaque,
                  child: JournalNotebookCover(
                    width: widget.width,
                    height: widget.height,
                    userName: widget.userName,
                    signName: widget.signName,
                    signGlyph: widget.signGlyph,
                    isEditable: widget.isEditable,
                    onTap: null,
                    onNameChanged: widget.onNameChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Opened Journal card designed purely with Flutter widgets
class OpenedJournalCard extends StatelessWidget {
  const OpenedJournalCard({
    super.key,
    required this.onWriteEntry,
    this.onTapPage,
  });

  final VoidCallback onWriteEntry;
  final VoidCallback? onTapPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapPage,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            return Stack(
              fit: StackFit.expand,
              children: [
                // 1. Subtle top rim showing the teal backing cover
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 1.h,
                  child: Container(color: const Color(0xFF7FA7AE)),
                ),

                // 3. Left Page Spine Gutter Shadow
                Positioned(
                  left: w * 0.13,
                  top: 0,
                  bottom: 0,
                  width: w * 0.15,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFFFFFFFF).withValues(alpha: 0.0),
                          const Color(0xFFE8E8E4).withValues(alpha: 0.35),
                          const Color(0xFFC8C8C4).withValues(alpha: 0.55),
                          const Color(0xFFAAAAA6).withValues(alpha: 0.38),
                          const Color(0xFFD6D6D2).withValues(alpha: 0.45),
                          const Color(0xFFF5F5F1).withValues(alpha: 0.15),
                          const Color(0xFFFFFFFF).withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.20, 0.38, 0.48, 0.58, 0.78, 1.0],
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  left: w * 0.18,
                  right: w * 0.05,
                  top: h * 0.08,
                  bottom: h * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Your Thoughts\nDeserves A Place",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamily,
                              fontSize: 21.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF191919),
                              height: 1.25,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        "Start Your First Entry And Begin Your\n  Journalising Journey Today",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7477),
                          height: 1.45,
                          letterSpacing: 0.1,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      InkWell(
                        key: const Key('write_first_entry_button'),
                        onTap: onWriteEntry,
                        borderRadius: BorderRadius.circular(24.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1B5E6B), Color(0xFF459E9E)],
                            ),
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1B5E6B)
                                    .withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit_note_rounded,
                                  size: 18.r,
                                  color: AppColors.white,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Write Your First Entry",
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
