import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/features/home/presentation/widgets/home_header.dart';
import 'package:test_app/features/home/presentation/widgets/roatating_time_dial.dart';

void main() {
  test('DialRing configurations match Figma pixel-perfection measurements', () {
    expect(dialRings.length, 6);

    // Verify exact outer band fractions
    expect(dialRings[0].outerFraction, 1.000);
    expect(dialRings[1].outerFraction, 0.846);
    expect(dialRings[2].outerFraction, 0.693);
    expect(dialRings[3].outerFraction, 0.558);
    expect(dialRings[4].outerFraction, 0.424);
    expect(dialRings[5].outerFraction, 0.283);

    // Verify exact label midpoints
    expect(dialRings[0].labelFraction, 0.923);
    expect(dialRings[1].labelFraction, 0.769);
    expect(dialRings[2].labelFraction, 0.625);
    expect(dialRings[3].labelFraction, 0.491);
    expect(dialRings[4].labelFraction, 0.353);
    expect(dialRings[5].labelFraction, 0.211);

    // Verify exact band colors sampled from Figma export
    expect(dialRings[0].bandColor, AppColors.yearsColor);
    expect(dialRings[1].bandColor, AppColors.monthsColor);
    expect(dialRings[2].bandColor, AppColors.daysColor);
    expect(dialRings[3].bandColor, AppColors.hrsColor);
    expect(dialRings[4].bandColor, AppColors.minColor);
    expect(dialRings[5].bandColor, AppColors.secColor);

    // Verify exact inactive colors
    expect(dialRings[0].inactiveColor, AppColors.yrsInactiveColor);
    expect(dialRings[1].inactiveColor, AppColors.monthInactiveColor);
    expect(dialRings[2].inactiveColor, AppColors.dayInactiveColor);
    expect(dialRings[3].inactiveColor, AppColors.hourInactiveColor);
    expect(dialRings[4].inactiveColor, AppColors.minsColorInactive);
    expect(dialRings[5].inactiveColor, AppColors.secColorInactive);
  });

  testWidgets('RotatingTimeDial and HomeHeader render quadrant with centered labels', (tester) async {
    tester.view.physicalSize = const Size(375 * 2.0, 812 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return const MaterialApp(
            home: Scaffold(
              body: HomeHeader(),
            ),
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(HomeHeader), findsOneWidget);
    expect(find.byType(RotatingTimeDial), findsOneWidget);

    // Verify all 6 band labels along the bottom edge
    expect(find.text('Yrs'), findsOneWidget);
    expect(find.text('Mm'), findsOneWidget);
    expect(find.text('Days'), findsOneWidget);
    expect(find.text('Hrs'), findsOneWidget);
    expect(find.text('Mins'), findsOneWidget);
    expect(find.text('Sec'), findsOneWidget);

    // Verify active numbers are present
    final now = DateTime.now();
    expect(find.text('${now.year % 100}'), findsAtLeast(1));
    expect(find.text('${now.month}'), findsAtLeast(1));
    expect(find.text('${now.day}'), findsAtLeast(1));
  });
}
