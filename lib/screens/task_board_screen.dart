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

  // [NEW] Logic para sa "Done" button
  void _markAsDone(String id) {
    setState(() {
      final index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        // Update natin yung status to 'done'
        tasks[index].status = Status.done;
      }
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
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0), // [FIX] Added spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Can change: Dashboard title
              Text(
                'MiniJira Sprint',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 4),
              Text(
                'Software Project Board',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Added spacing here so title doesn't touch cards
                const SizedBox(height: 20),
                // Requirement A1: summary ng sprint (3 containers)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatBox(
                          title: "To Do",
                          count: toDoCount,
                          color: AppColors.toDoStatus,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: StatBox(
                          title: "In Progress",
                          count: inProgressCount,
                          color: AppColors.inProgressStatus,
                        ),
                      ),
                      const SizedBox(width: 8),
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
                const SizedBox(height: 16),
                // Requirement E: Summary Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SummaryCard(
                    total: tasks.length,
                    done: doneCount,
                    remaining: toDoCount + inProgressCount,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Requirement E: Quick Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("All Issues", Filter.all),
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
                    onDone: () =>
                        _markAsDone(task.id), // [NEW] Pass the function here
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
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          "Create Issue",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
          boxShadow: isSelected 
            ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))] 
            : [],
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