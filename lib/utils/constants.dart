import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2962FF);
  static const primaryDark = Color(0xFF0039CB);
  static const primaryLight = Color(0xFF768FFF);
  static const secondary = Color(0xFF00BFA5);
  static const secondaryDark = Color(0xFF008E76);
  static const secondaryLight = Color(0xFF5DF2D6);
  static const error = Color.fromARGB(255, 203, 71, 0);
  static const success = Color(0xFF388E3C);
  static const warning = Color(0xFFFFA000);
  static const background = Color(0xFFFAFAFA);
}

class AppTextStyles {
  static const header1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const header2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static const buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 16, 16, 16),
  );
}

class AppDimens {
  static const paddingSmall = 8.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 24.0;
  static const borderRadius = 12.0;
  static const buttonHeight = 48.0;
}
