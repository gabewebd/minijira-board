import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../utils/constants.dart';
import 'priority_badge.dart';

// [Requirement C: ListView + Card UI]
// Ito yung hitsura dapat ng bawat task sa listahan.
class TaskCard extends StatelessWidget {
  final Task task;
  // Mga functions na galing sa parent widget (TaskBoardScreen)
  // Para gumana yung buttons (Edit, Delete, Mark as Done)
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onDone;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // white na may rounded corners at shadow para eleveated tingnan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // [UPDATED] Row 1: Badges at Actions
          // Gumamit ako ng Row sa loob ng Row para maganda alignment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Priority Badge at Status Chip
              Row(
                children: [
                  // 1. Priority Chip (e.g. HIGH) - Gamit yung PriorityBadge widget
                  PriorityBadge(priority: task.priority),
                  const SizedBox(width: 8),
                  
                  // 2. Status Chip (e.g. TO DO)
                  // Gumamit ako ng helper method _buildTag sa baba para malinis tingnan
                  _buildTag(
                    text: _getStatusText(task.status),
                    color: _getStatusColor(task.status),
                  ),
                ],
              ),

              // Right side: Action Buttons (Edit/Delete)
              // Gumamit ako ng IconButton para maliit at malinis
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.redAccent,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Task Title
          Text(
            task.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              // Strikethrough effect kapag tapos na yung task
              decoration: task.status == Status.done
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          const SizedBox(height: 4),

          // Task Description (Subtitle)
          Text(
            task.description,
            maxLines: 2, // Limit sa 2 lines para hindi sobrang haba
            overflow: TextOverflow.ellipsis, // Magkakaroon ng "..." sa dulo pag mahaba
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 16),

          // Done Button
          // Nagpapakita lang to kapag HINDI pa tapos ang task
          if (task.status != Status.done)
            SizedBox(
              width: double.infinity, // Full width button
              child: ElevatedButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.check_circle, size: 16),
                label: Text(
                  "Mark as Done",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[50], // Light green bg
                  foregroundColor: Colors.green[700], // Dark green text
                  elevation: 0, // Flat design, walang shadow
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper widget: Para hindi tayo paulit-ulit ng styling sa chips
  Widget _buildTag({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1), // Light background color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1), // Border color
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // Helper function: Status enum to text na gusto natin makita
  String _getStatusText(Status status) {
    switch (status) {
      case Status.toDo:
        return "TO DO";
      case Status.inProgress:
        return "IN PROGRESS";
      case Status.done:
        return "COMPLETED";
    }
  }

  // Helper function: kulay depende sa status
  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.toDo:
        return AppColors.toDoStatus;
      case Status.inProgress:
        return AppColors.inProgressStatus;
      case Status.done:
        return AppColors.doneStatus;
    }
  }
}