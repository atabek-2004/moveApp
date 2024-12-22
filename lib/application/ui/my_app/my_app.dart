import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routes: mainNavigation.routes,
          initialRoute: mainNavigation.initialRoute,
          onGenerateRoute: mainNavigation.onGenerateRoute,
        );
      },
    );
  }
}
