import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// [INSTRUCTION] Requirement F: Reusable Widget
class StatBox extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const StatBox({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.shade50,
        ), // [CHANGEABLE] Subtle purple border
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
