import 'package:flutter/material.dart';

class AppColors {
  // Modern Clean Palette
  static const Color primary = Color(0xFF2D3436);       // Dark Charcoal (Buttons/Headers)
  static const Color secondary = Color(0xFF6C5CE7);     // Soft Purple (Accents)
  static const Color background = Color(0xFFF8F9FA);    // Off-white background
  static const Color surface = Colors.white;            // Card backgrounds
  
  // Status Colors (Pastel/Soft)
  static const Color toDoStatus = Color(0xFF74B9FF);    // Soft Blue
  static const Color inProgressStatus = Color(0xFFA29BFE);// Soft Purple
  static const Color doneStatus = Color(0xFF00B894);    // Soft Teal

  // Priority Colors
  static const Color highPriority = Color(0xFFFF7675);  // Soft Red
  static const Color mediumPriority = Color(0xFFFDCB6E); // Soft Orange
  static const Color lowPriority = Color(0xFF55EFC4);   // Soft Mint

  // Counter Colors (Logic Specific)
  static const Color counterSafe = Color(0xFF00B894);   // Teal
  static const Color counterWarning = Color(0xFFFDCB6E);// Orange
  static const Color counterDanger = Color(0xFFFF7675); // Red
  
  // Text
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
}

class AppStyles {
  static const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(24)); // More rounded
  static const double cardElevation = 0; // Flat style with border preference
  static const double titleFontSize = 20.0;
  static const double bodyFontSize = 15.0;
}