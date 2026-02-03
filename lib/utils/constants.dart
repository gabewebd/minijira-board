import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors: Ito yung main theme ng app natin (StudySprint) ---
  static const Color primary = Color(0xFF6246EA); // Deep Purple (Pang-header at titles)
  static const Color secondary = Color(0xFF00BFA5); // Teal (Pang-buttons at accents)
  static const Color background = Color(0xFFF3F4F6); // Light Gray (Malinis na background)
  static const Color surface = Colors.white; // White para sa Cards at Containers

  // --- Text Colors ---
  static const Color textPrimary = Color(0xFF2B2B2B); // Dark Grey (Main text)
  static const Color textSecondary = Color(0xFF757575); // Grey (Subtitle / description)

  // --- Counter Colors (Para sa Requirement B2 - Character Limit) ---
  // Nag-iiba kulay depende sa haba ng description
  static const Color counterSafe = Color(0xFF00C853); // Green (Safe pa)
  static const Color counterWarning = Color(0xFFFFAB00); // Amber (Malapit na mapuno)
  static const Color counterDanger = Color(0xFFD50000); // Red (Lagpas na / Danger)

  // --- Status Colors (Para sa mga stats sa dashboard) ---
  static const Color toDoStatus = Color(0xFFFF9800); // Orange (To Do)
  static const Color inProgressStatus = Color(0xFF6246EA); // Purple (In Progress)
  static const Color doneStatus = Color(0xFF00C853); // Green (Done)

  // --- Priority Colors (Ginagamit sa PriorityBadge widget) ---
  static const Color highPriority = Color(0xFFFF5252); // Soft Red (High)
  static const Color mediumPriority = Color(0xFFFFAB40); // Soft Orange (Medium)
  static const Color lowPriority = Color(0xFF448AFF); // Soft Blue (Low)
}