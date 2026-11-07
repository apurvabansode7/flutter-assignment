


import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_images.dart';
import 'package:test_app/core/constants/app_typography.dart';

class DestinyCard extends StatelessWidget {
  const DestinyCard({
    super.key,
    this.destinyNumber = 7,
    this.destinyTitle = 'The Seeker',
    this.onTap,
  });

  final int destinyNumber;
  final String destinyTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AspectRatio(
        aspectRatio: 1608 / 1400,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            // Original asset proportions
            final sunSize = w * (352 / 1608);

            final treeWidth = w * (498 / 1608);
            final treeHeight = h * (504 / 1400);

            final personWidth = w * (132 / 1608);
            final personHeight = h * (456 / 1400);

            final pathHeight = h * (766 / 1400);

            return ClipRRect(
              borderRadius: BorderRadius.circular(w * 0.0143),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  // 1. White background
                  const Positioned.fill(
                    child: ColoredBox(
                      color: AppColors.white,
                    ),
                  ),

                  // 2. Winding path
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: pathHeight,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.path,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // 3. Sun circle
                  Positioned(
                    top: h * (322 / 1400),
                    left: (w - sunSize) / 2,
                    width: sunSize,
                    height: sunSize,
                    child: Container(
                      alignment: const Alignment(0, -0.04),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFDF0CD),
                       
                      ),
                      child: Text(
                        '$destinyNumber',
                        style: AppTypography.destinyCardNumber.copyWith(
                          fontSize: w * 0.10,
                        ),
                      ),
                    ),
                  ),

                  // 4. Left tree
                  Positioned(
                    left: 0,
                    top: h * (196 / 1400),
                    width: treeWidth,
                    height: treeHeight,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.tree2,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  ),

                  // 5. Right tree
                  Positioned(
                    right: 0,
                    top: h * (196 / 1400),
                    width: treeWidth,
                    height: treeHeight,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.tree,
                        fit: BoxFit.fill,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),

                  // 6. Center person
                  Positioned(
                    left: (w - personWidth) / 2,
                    top: h * (610 / 1400),
                    width: personWidth,
                    height: personHeight,
                    child: IgnorePointer(
                      child: Image.asset(
                        AppImages.man,
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),

                  // 7. Bottom title and subtitle
                  Positioned(
                    left: w * 0.04,
                    right: w * 0.04,
                    bottom: h * (80 / 1400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Destiny Number $destinyNumber',
                          textAlign: TextAlign.center,
                          style: AppTypography.destinyCardTitle.copyWith(
                            fontSize: w * 0.042,
                            fontFamily: AppTypography.fontFamily2,
                          ),
                        ),

                        SizedBox(height: h * (15 / 1400)),

                        Text(
                          destinyTitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.destinyCardSubtitle.copyWith(
                            fontSize: w * 0.036,
                            fontFamily: AppTypography.fontFamily2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
