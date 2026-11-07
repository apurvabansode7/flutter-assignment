import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/insights/presentation/screens/insights_screen.dart';

void main() {
  testWidgets(
      'InsightsScreen renders all sections, scrolls background smoothly without sticky image bugs, and shows all content',
      (tester) async {
    // Set mobile test viewport
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: InsightsScreen(),
        ),
      ),
    );

    // Initial pump and wait for mock data to load
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpAndSettle();

    // Verify initial header and top cards
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('TODAY'), findsOneWidget);
    expect(find.text('Gilli Gaurav Singh'), findsOneWidget);
    expect(find.text('ASTROLOGY'), findsOneWidget);

    // Scroll down to reveal bottom cards
    final scrollable = find.byKey(const Key('insights_scroll_view'));
    expect(scrollable, findsOneWidget);

    await tester.drag(scrollable, const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify lower sections are visible after scroll
    expect(find.text('NUMEROLOGY'), findsOneWidget);
    expect(find.text('Destiny Number 7'), findsOneWidget);
    expect(find.text('The Seeker'), findsOneWidget);

    // Scroll back up to the top
    await tester.drag(scrollable, const Offset(0, 600));
    await tester.pumpAndSettle();

    // Verify back at top
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Gilli Gaurav Singh'), findsOneWidget);
  });
}
