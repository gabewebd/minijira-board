import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../data/mock_data.dart';
import '../utils/constants.dart';
import '../widgets/stat_box.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';
import 'task_form_screen.dart';

enum Filter { all, highPriority, done }

class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({super.key});

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  // Data source
  List<Task> tasks = mockTasks;

  // Navigation to TaskForm
  void _navigateToForm({Task? task}) async {
    final result = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (context) => TaskFormScreen(task: task)),
    );
    if (result != null) {
      setState(() {
        if (task == null) {
          tasks.add(result);
        } else {
          final index = tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) tasks[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MiniJira Board',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 26,
                ),
              ),
              Text(
                'Sprint Overview',
                style: GoogleFonts.cabin(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
      
      body: Container(),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        icon: const Icon(Icons.add, color: Colors.white, size: 24),
        label: Text(
          "Add Task", 
          style: GoogleFonts.cabin(
            fontWeight: FontWeight.bold, 
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}