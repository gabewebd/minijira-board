import 'package:flutter/material.dart';

class AppColors {
  // [CHANGEABLE] THEME: "StudySprint" (Purple & Amber)
  static const Color primary = Color(
    0xFF673AB7,
  ); // Deep Purple (Header/Buttons)
  static const Color secondary = Color(0xFFFFC107); // Amber (Accents/Active)
  static const Color background = Color(0xFFF3E5F5); // Light Purple/White Tint
  static const Color surface = Colors.white;

  // [INSTRUCTION] Requirement: "Counter text must change color... Safe / Warning / Danger"
  // [CHANGEABLE] You can pick specific colors, but they must represent these states.
  static const Color counterSafe = Color(0xFF4CAF50); // Green
  static const Color counterWarning = Color(0xFFFF9800); // Orange
  static const Color counterDanger = Color(0xFFF44336); // Red

  // [CHANGEABLE] Status Colors (Visuals)
  static const Color toDoStatus = Color(0xFF9E9E9E); // Grey
  static const Color inProgressStatus = Color(0xFFFFC107); // Amber (Busy)
  static const Color doneStatus = Color(0xFF4CAF50); // Green (Complete)

  // [CHANGEABLE] Priority Colors
  static const Color highPriority = Color(0xFFE91E63); // Pink/Red
  static const Color mediumPriority = Color(0xFF2196F3); // Blue
  static const Color lowPriority = Color(0xFF009688); // Teal

  static const Color textPrimary = Color(0xFF311B92); // Dark Deep Purple
  static const Color textSecondary = Color(0xFF757575); // Grey
}

class AppStyles {
  // [CHANGEABLE] Styling constants
  static const BorderRadius cardBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );
  static const double cardElevation = 3;
}
