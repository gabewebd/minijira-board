import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

// [INSTRUCTION] Requirement E: Summary Card
class SummaryCard extends StatelessWidget {
  final int total;
  final int done;
  final int remaining;

  const SummaryCard({
    super.key,
    required this.total,
    required this.done,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // [CHANGEABLE] Purple to Deep Purple Gradient
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF4527A0)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item("Total", total),
          Container(width: 1, height: 30, color: Colors.white24),
          _item("Done", done),
          Container(width: 1, height: 30, color: Colors.white24),
          _item("Left", remaining),
        ],
      ),
    );
  }

  Widget _item(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ), // Amber text
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
