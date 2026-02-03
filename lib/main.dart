import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/task_board_screen.dart';
import 'utils/constants.dart';

void main() {
  // Dito nagsisimula ang takbo ng app natin
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title ng app pag tinignan sa recent apps list
      title: 'Mini Jira Board',
      
      debugShowCheckedModeBanner: false,
      
      // Global Theme: Dito natin sineset yung kulay at font ng buong app
      // para consistent tignan kahit saang screen pumunta.
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        
        // Gamit tayo ng Poppins font para modern at malinis tignan (Student-friendly vibe)
        fontFamily: GoogleFonts.poppins().fontFamily,
        
        // Default style ng AppBar (yung header sa taas)
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0, // Flat design, walang shadow
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white), // Puti yung mga back button/icons
        ),
        
        // Default style nung "Add" button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondary, // Teal/Amber accent color natin
          foregroundColor: Colors.white, // Kulay ng icon sa loob
        ),
      ),
      
      // [Requirement] Home screen dapat yung Task Board (Screen A)
      home: const TaskBoardScreen(),
    );
  }
}