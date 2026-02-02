import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../data/mock_data.dart';
import '../utils/constants.dart';
import '../widgets/stat_box.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';
import 'task_form_screen.dart';

// Requirement: quick filter
enum Filter { all, highPriority, done }

class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({super.key});

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  // List ng tasks galing sa mock data (nasa memory lang)
  List<Task> tasks = List.from(mockTasks);
  Filter _currentFilter = Filter.all;

  // CRUD and navigation
  void _navigateToForm({Task? task}) async {
    final result = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (context) => TaskFormScreen(task: task)),
    );
    if (result != null) {
      setState(() {
        if (task == null) {
          tasks.add(result); // Create
        } else {
          final index = tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) tasks[index] = result; // Update
        }
      });
    }
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((t) => t.id == id); // Delete
    });
  }

  // Filter logic
  List<Task> get _filteredTasks {
    switch (_currentFilter) {
      case Filter.highPriority:
        return tasks.where((t) => t.priority == Priority.high).toList();
      case Filter.done:
        return tasks.where((t) => t.status == Status.done).toList();
      default:
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int toDoCount = tasks.where((t) => t.status == Status.toDo).length;
    final int inProgressCount = tasks
        .where((t) => t.status == Status.inProgress)
        .length;
    final int doneCount = tasks.where((t) => t.status == Status.done).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Can change: Dashboard title
            Text(
              'StudySprint Board',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              'Academic Planner',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Requirement A1: summary ng sprint (3 containers)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: StatBox(
                    title: "To Do",
                    count: toDoCount,
                    color: AppColors.toDoStatus,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatBox(
                    title: "Studying",
                    count: inProgressCount,
                    color: AppColors.inProgressStatus,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatBox(
                    title: "Done",
                    count: doneCount,
                    color: AppColors.doneStatus,
                  ),
                ),
              ],
            ),
          ),

          // Requirement E: Summary Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SummaryCard(
              total: tasks.length,
              done: doneCount,
              remaining: toDoCount + inProgressCount,
            ),
          ),

          const SizedBox(height: 16),

          // Requirement E: Quick Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("All Work", Filter.all),
                const SizedBox(width: 10),
                _buildFilterChip("High Priority", Filter.highPriority),
                const SizedBox(width: 10),
                _buildFilterChip("Completed", Filter.done),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Requirement A2: listahan ng tasks
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCard(
                    task: task,
                    onEdit: () => _navigateToForm(task: task),
                    onDelete: () => _deleteTask(task.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Requirement A3: button para makapag-add ng task
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(),
        icon: const Icon(Icons.edit_note, color: Colors.black),
        label: Text(
          "New Assignment",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Filter filter) {
    final bool isSelected = _currentFilter == filter;
    return GestureDetector(
      onTap: () => setState(() => _currentFilter = filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
