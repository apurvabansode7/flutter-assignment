import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_responsive.dart';
import 'package:test_app/core/constants/app_typography.dart';

class NavItemData {
  const NavItemData({
    required this.label,
    required this.img,
    required this.selectedImg,
  });

  final String label;
  final String img;
  final String selectedImg;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _bg = AppColors.white;
  static const _selected = AppColors.primary;
  static const _unselected = AppColors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _bg,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppResponsive.heightScale(72),
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final selected = index == currentIndex;
              final color = selected ? _selected : _unselected;

              return Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => onTap(index),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Indicator shown at the top when selected
                      if (selected)
                        const SelectedTabIndicator(color: _selected),

                      // Nav Icon and Label
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(scale: animation, child: child),
                              child: SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child: Image.asset(
                                  selected ? item.selectedImg : item.img,
                                  key: ValueKey(selected),
                                  fit: BoxFit.contain,
                                  color: color,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: AppTypography.regular12.copyWith(
                                fontSize: 11.sp,
                                color: color,
                                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                              ),
                              child: Text(item.label),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// Simple widget design using standard Containers & RadialGradient
class SelectedTabIndicator extends StatelessWidget {
  const SelectedTabIndicator({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppResponsive.widthScale(32),
          height: AppResponsive.heightScale(4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
