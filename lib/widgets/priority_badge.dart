import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../utils/constants.dart';

class PriorityBadge extends StatelessWidget {
  // Kailangan natin ipasa dito kung "High", "Medium", or "Low" ba
  final Priority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    // Kunin muna natin yung tamang kulay gamit yung function sa baba
    final color = _getColor(priority);

    return Container(
      // Padding para hindi dikit masyado yung text sa gilid
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      
      // Dito yung styling nung mismong badge (background at border)
      decoration: BoxDecoration(
        // Ginawang light version (opacity 0.1) yung background color para hindi masakit sa mata
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8), // Rounded corners para smooth tingnan
        // Manipis na border na medyo transparent din
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      
      child: Text(
        // .toUpperCase() para maging "HIGH", "MEDIUM", "LOW" yung display
        priority.name.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color, // Yung text mismo, solid color gamit
        ),
      ),
    );
  }

  // Helper function: Pipili ng kulay sa AppColors depende sa priority level
  Color _getColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return AppColors.highPriority; // Red pag urgent/high
      case Priority.medium:
        return AppColors.mediumPriority; // Orange pag medium  lang
      case Priority.low:
        return AppColors.lowPriority; // Blue pag low  lang
    }
  }
}