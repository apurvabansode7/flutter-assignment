import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/home/presentation/screens/home_screen.dart';
import 'package:test_app/features/home/presentation/widgets/goals_card.dart';
import 'package:test_app/features/home/presentation/widgets/greeting_card.dart';
import 'package:test_app/features/home/presentation/widgets/home_header.dart';
import 'package:test_app/features/home/presentation/widgets/horscope_card.dart';
import 'package:test_app/features/home/presentation/widgets/journal_card.dart';
import 'package:test_app/features/home/presentation/widgets/numerology_card.dart';
import 'package:test_app/features/home/presentation/widgets/roatating_time_dial.dart';

void main() {
  testWidgets('HomeScreen renders all sections, dial, cards, and labels with responsive fidelity', (tester) async {
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
            home: HomeScreen(),
          );
        },
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Header and Rotating Time Dial
    expect(find.byType(HomeHeader), findsOneWidget);
    expect(find.byType(RotatingTimeDial), findsOneWidget);
    expect(find.byType(Greeting), findsOneWidget);
    expect(find.text('Saniya'), findsOneWidget);

    // Verify Dial ring labels
    expect(find.text('Yrs'), findsOneWidget);
    expect(find.text('Mm'), findsOneWidget);
    expect(find.text('Days'), findsOneWidget);
    expect(find.text('Hrs'), findsOneWidget);
    expect(find.text('Mins'), findsOneWidget);
    expect(find.text('Sec'), findsOneWidget);

    // Verify Section Titles
    expect(find.text("GOAL'S"), findsOneWidget);
    expect(find.text("TODAY'S HOROSCOPE"), findsOneWidget);
    expect(find.text("TODAY'S NUMEROLOGY"), findsOneWidget);
    expect(find.text("YOUR JOURNAL"), findsOneWidget);

    // Verify Cards
    expect(find.byType(GoalsCard), findsOneWidget);
    expect(find.byType(HoroscopeCard), findsOneWidget);

    // Scroll down to check lower cards
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.byType(NumerologyCard), findsOneWidget);
    expect(find.byType(JournalCard), findsOneWidget);
    expect(find.text("SANIYA'S JOURNAL"), findsOneWidget);
  });
}
