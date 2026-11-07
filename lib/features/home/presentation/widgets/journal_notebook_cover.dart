import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

class JournalNotebookCover extends StatefulWidget {
  const JournalNotebookCover({
    super.key,
    this.userName = 'Saniya',
    this.signName = 'Libra',
    this.signGlyph,
    this.width,
    this.height,
    this.isEditable = true,
    this.onTap,
    this.onNameChanged,
  });

  final String userName;
  final String signName;
  final String? signGlyph;
  final double? width;
  final double? height;
  final bool isEditable;
  final VoidCallback? onTap;
  final ValueChanged<String>? onNameChanged;

  @override
  State<JournalNotebookCover> createState() => _JournalNotebookCoverState();
}

class _JournalNotebookCoverState extends State<JournalNotebookCover> {
  late String _currentName;

  @override
  void initState() {
    super.initState();
    _currentName = widget.userName;
  }

  @override
  void didUpdateWidget(covariant JournalNotebookCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userName != widget.userName) {
      _currentName = widget.userName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
         
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: AspectRatio(
            aspectRatio: 1452 / 1693,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;

                // final centerDiameter = w * 0.22;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Constant High-Res Base Artwork
                    Image.asset(
                      AppImages.journalCover,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),

                    // 2. Dynamic Editable Name Label at Top
                    Positioned(
                      left: w * 0.262,
                      top: h * 0.087,
                      width: w * 0.555,
                      height: h * 0.103,
                      child: Material(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        elevation: 2,
                        shadowColor: AppColors.dark.withValues(alpha: 0.12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.r),
                          //  onTap: widget.isEditable ? _showEditNameDialog : widget.onTap,
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${_currentName.toUpperCase()}'S JOURNAL",
                                      style: TextStyle(
                                        fontFamily: AppTypography.fontFamily,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF0F363E),
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
