import 'package:flutter/material.dart';
import 'package:move/application/ui/screens/page_view/page_view_widget.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:move/resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PageViewWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.splashScreenImage,
              width: 350,
              height: 200,
            ),
            const SizedBox(height: 12),
            const Text(
              'Переезжайте с удовольствием',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.41,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
