import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../utils/constants.dart';

class TaskCard extends StatelessWidget {
  final Task task;
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
          // [UPDATED] Row for both Priority AND Status Tags
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // 1. Priority Chip (e.g. HIGH)
                  _buildTag(
                    text: task.priority.name.toUpperCase(),
                    color: _getPriorityColor(task.priority),
                  ),
                  const SizedBox(width: 8),
                  // 2. [NEW] Status Chip (e.g. STUDYING)
                  _buildTag(
                    text: _getStatusText(task.status),
                    color: _getStatusColor(task.status),
                  ),
                ],
              ),

              // Action Buttons (Edit/Delete)
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
              decoration: task.status == Status.done
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          const SizedBox(height: 4),

          // Task Description
          Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 16),

          // Done Button (Only shows if NOT Done)
          if (task.status != Status.done)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onDone,
                icon: const Icon(Icons.check_circle, size: 16),
                label: Text(
                  "Mark as Done",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[50],
                  foregroundColor: Colors.green[700],
                  elevation: 0,
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

  // Helper widget para hindi paulit-ulit yung code ng tags
  Widget _buildTag({required String text, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
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

  // Helper para sa text display ng status
  String _getStatusText(Status status) {
    switch (status) {
      case Status.toDo:
        return "TO DO";
      case Status.inProgress:
        return "STUDYING"; // Ito yung gusto mo makita
      case Status.done:
        return "COMPLETED";
    }
  }

  // Helper para sa colors ng status
  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.toDo:
        return Colors.blueGrey;
      case Status.inProgress:
        return Colors.orange; // Color for Studying
      case Status.done:
        return Colors.green;
    }
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.amber[800]!;
      case Priority.low:
        return Colors.blue;
    }
  }
}
