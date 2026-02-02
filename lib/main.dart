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
      title: 'Mini Jira Board',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: GoogleFonts.cabin().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          titleTextStyle: GoogleFonts.cabin(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyles.cardBorderRadius,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: AppStyles.cardBorderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppStyles.cardBorderRadius,
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.cardBorderRadius,
          ),
          elevation: AppStyles.cardElevation,
        ),
      ),
      home: const TaskBoardScreen(),
    );
  }
}
