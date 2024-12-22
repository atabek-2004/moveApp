import 'package:flutter/material.dart';

class AppTheme {
  static const appColor = Color(0xFF007AFF);
  static const foreGroundColor = Colors.white;
  static const scaffoldBackgroundColor = Color(0xFFF5F5F5);
  static const styleOfAppBarText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: -0.40799999237060547,
    fontFamily: 'Open Sans',
  );
  static const thingBoxDeliverTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: -0.40799999237060547,
    fontFamily: 'Open Sans',
  );

  static const mainMenuTextsStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.black,
    letterSpacing: -0.40799999237060547,
    fontFamily: 'Open Sans',
  );

  static const headerSmallTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: -0.41,
  );

  static final buttonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    backgroundColor: const WidgetStatePropertyAll(AppTheme.appColor),
    foregroundColor: const WidgetStatePropertyAll(AppTheme.foreGroundColor),
  );

  static const buttonTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white);
  static const containerColor = Color(0xFFFFFFFF);
}
