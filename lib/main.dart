import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/constants/app_responsive.dart';
import 'package:test_app/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(
    //DevicePreview(
      //enabled: !kReleaseMode,
      //builder: (context) => 
      const MyApp(),
    //),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppResponsive.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'My App',
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
              primary: AppColors.primary,
              secondary: AppColors.teal,
              surface: AppColors.grey,
              onSurface: AppColors.dark,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
