import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';

// [Requirement E: Summary Card]
// Ito yung colorful card sa gitna pinapakita overall progress
// (Total / Done / Remaining).
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
      // Gumamit ako ng LinearGradient (Blue Purple Teal) para modern tingnan.
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2962FF), Color(0xFF6246EA), Color(0xFF00BFA5)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: [
          // Nilagyan ko ng shadow para umangat siya tingnan sa background
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Pantay na spacing
        children: [
          _item("Total", total),
          // Vertical divider: Manipis na line lang sa pagitan ng stats
          Container(width: 1, height: 30, color: Colors.white24),
          _item("Done", done),
          Container(width: 1, height: 30, color: Colors.white24),
          _item("Left", remaining),
        ],
      ),
    );
  }

  // Helper widget para hindi paulit-ulit yung code ng Column at Text
  Widget _item(String label, int count) {
    return Column(
      children: [
        // Yung malaking number
        Text(
          count.toString(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // Yung label sa ilalim (e.g. "Total", "Done")
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}