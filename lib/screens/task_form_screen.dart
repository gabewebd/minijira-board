import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../utils/constants.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;

  Priority _selectedPriority = Priority.low;
  Status _selectedStatus = Status.toDo;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    if (widget.task != null) {
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // [INSTRUCTION] Requirement B2: Counter Colors
  Color _getCounterColor(int length) {
    if (length <= 40) return AppColors.counterSafe;
    if (length <= 80) return AppColors.counterWarning;
    return AppColors.counterDanger;
  }

  String _getCounterText(int length) {
    if (length <= 40) return "Safe";
    if (length <= 80) return "Warning";
    return "Danger";
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Task(
          id: widget.task?.id ?? DateTime.now().toString(),
          title: _titleController.text,
          description: _descController.text,
          priority: _selectedPriority,
          status: _selectedStatus,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final int descLen = _descController.text.length;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(widget.task == null ? "New Assignment" : "Edit Assignment"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title ---
                  _buildLabel("Subject / Title"),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "E.g., Math Homework",
                    ),
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 20),

                  // --- Description ---
                  _buildLabel("Details"),
                  TextFormField(
                    controller: _descController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Enter details...",
                    ),
                    onChanged: (v) => setState(() {}),
                    // [INSTRUCTION] Requirement: Prevent Save if > 120
                    validator: (v) => v!.length > 120
                        ? "Too long!"
                        : (v.isEmpty ? "Required" : null),
                  ),
                  const SizedBox(height: 8),

                  // [INSTRUCTION] Requirement B2: Counter
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$descLen / 120",
                          style: TextStyle(
                            color: _getCounterColor(descLen),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Status: ${_getCounterText(descLen)}",
                          style: TextStyle(
                            color: _getCounterColor(descLen),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Priority & Status ---
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Priority"),
                            DropdownButtonFormField<Priority>(
                              value: _selectedPriority,
                              items: Priority.values
                                  .map(
                                    (p) => DropdownMenuItem(
                                      value: p,
                                      child: Text(p.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _selectedPriority = v!),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Status"),
                            DropdownButtonFormField<Status>(
                              value: _selectedStatus,
                              items: Status.values
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(
                                        s.name == 'toDo'
                                            ? 'To Do'
                                            : s.name == 'inProgress'
                                            ? 'Studying'
                                            : 'Done',
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _selectedStatus = v!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // --- Save Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: descLen > 120 ? null : _saveTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary, // Amber
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Save Assignment",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
