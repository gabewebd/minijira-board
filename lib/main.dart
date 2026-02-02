import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/task_board_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // [CHANGEABLE] App Title
      title: 'StudySprint',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        // [CHANGEABLE] Font choice (Poppins is very modern/student-friendly)
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondary, // Amber button
          foregroundColor: Colors.black, // Dark icon on amber
        ),
      ),
      // [INSTRUCTION] Requirement: Open Screen A (Task Board)
      home: const TaskBoardScreen(),
    );
  }
}
