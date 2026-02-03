import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// [Requirement F: Reusable Widget Elements]
// Ito yung reusable widget para sa mga stat boxes sa taas (To Do, In progress, Done).
// Ginawa natin 'to para hindi tayo copy-paste ng container code nang tatlong beses.
class StatBox extends StatelessWidget {
  final String title; // E.g., "To Do"
  final int count;    // E.g., 5
  final Color color;  // Kulay nung number (Orange/Purple/Green)

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
      // Design ng box: White background na may rounded corners at slight shadow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // Sobrang nipis na shadow lang para mukhang naka-angat konti
            color: Colors.deepPurple.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Yung malaking number sa gitna
          Text(
            count.toString(),
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: color, // Nag-iiba kulay depende sa status
            ),
          ),
          const SizedBox(height: 4),
          // Yung label sa ilalim (e.g. "To Do")
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14, 
              color: Colors.grey[600], // Grey lang para hindi nagpopop ung kulay
            ),
          ),
        ],
      ),
    );
  }
}