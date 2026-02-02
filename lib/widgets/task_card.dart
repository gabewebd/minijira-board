import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../utils/constants.dart';

// [INSTRUCTION] Requirement F: Reusable TaskCard
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriorityBadge(task.priority),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
            // [INSTRUCTION] Requirement A2: Title Bold
            Text(
              task.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            // [INSTRUCTION] Requirement A2: Desc Preview
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: _getStatusColor(task.status),
                ),
                const SizedBox(width: 6),
                Text(
                  _getStatusText(task.status),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(task.status),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(Status s) {
    switch (s) {
      case Status.toDo:
        return AppColors.toDoStatus;
      case Status.inProgress:
        return AppColors.inProgressStatus;
      case Status.done:
        return AppColors.doneStatus;
    }
  }

  String _getStatusText(Status s) {
    switch (s) {
      case Status.toDo:
        return "To Do";
      case Status.inProgress:
        return "Studying";
      case Status.done:
        return "Done";
    }
  }

  Widget _buildPriorityBadge(Priority p) {
    Color bg;
    Color text;
    String label;
    switch (p) {
      case Priority.high:
        bg = AppColors.highPriority.withOpacity(0.1);
        text = AppColors.highPriority;
        label = "URGENT";
        break;
      case Priority.medium:
        bg = AppColors.mediumPriority.withOpacity(0.1);
        text = AppColors.mediumPriority;
        label = "NORMAL";
        break;
      case Priority.low:
        bg = AppColors.lowPriority.withOpacity(0.1);
        text = AppColors.lowPriority;
        label = "LOW";
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: text,
        ),
      ),
    );
  }
}
