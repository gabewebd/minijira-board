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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  Priority _selectedPriority = Priority.low;
  Status _selectedStatus = Status.toDo;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // --- Logic: Counter Colors ---
  Color _getCounterColor(int length) {
    if (length <= 40) return Colors.green;
    if (length <= 80) return Colors.orange;
    return Colors.red;
  }

  String _getCounterStatusText(int length) {
    if (length <= 40) return 'Safe';
    if (length <= 80) return 'Warning';
    return 'Danger';
  }

  bool _isSaveDisabled() {
    return _descriptionController.text.length > 120;
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: widget.task?.id ?? DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        priority: _selectedPriority,
        status: _selectedStatus,
      );
      Navigator.of(context).pop(task);
    }
  }

  // --- UI Helpers for Distinct Icons ---
  
  // 1. Get Icon based on Priority Level (FLAGS)
  IconData _getPriorityIcon(Priority p) {
    return Icons.flag_rounded; 
  }

  Color _getPriorityColor(Priority p) {
    switch (p) {
      case Priority.high: return Colors.redAccent;
      case Priority.medium: return Colors.orange;
      case Priority.low: return Colors.green;
    }
  }

  // 2. Get Icon based on Status
  IconData _getStatusIcon(Status s) {
    switch (s) {
      case Status.toDo: 
        return Icons.radio_button_unchecked;
      case Status.inProgress: 
        return Icons.watch_later_outlined;
      case Status.done: 
        return Icons.check_circle_rounded;
    }
  }

  Color _getStatusColor(Status s) {
    switch (s) {
      case Status.toDo: 
        return Colors.grey;
      case Status.inProgress: 
        return const Color(0xFF6C5CE7);
      case Status.done: 
        return const Color(0xFF6C5CE7);
    }
  }

  @override
  Widget build(BuildContext context) {
    final descLength = _descriptionController.text.length;
    final counterColor = _getCounterColor(descLength);

    return Scaffold(
      backgroundColor: AppColors.primary, 
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.task == null ? 'Create New Task' : 'Edit Task',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold, 
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        
                        // --- Title Input ---
                        _buildLabel("Name"),
                        TextFormField(
                          controller: _titleController,
                          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: "Enter Task Name",
                            hintStyle: GoogleFonts.outfit(color: Colors.grey[400]),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 2)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          validator: (v) => (v == null || v.isEmpty) ? 'Please enter a title' : null,
                        ),
                        
                        const SizedBox(height: 24),

                        // --- Description Input ---
                        _buildLabel("Detail"),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          style: GoogleFonts.cabin(fontSize: 16, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: "Enter task description...",
                            hintStyle: GoogleFonts.cabin(color: Colors.grey[400]),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 2)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) => setState(() {}),
                          validator: (v) => (v == null || v.isEmpty) ? 'Required' : (v.length > 120 ? 'Too long' : null),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // --- Counter Row (UPDATED: Status Below Counter) ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$descLength / 120',
                              style: GoogleFonts.cabin(fontWeight: FontWeight.bold, color: counterColor),
                            ),
                            const SizedBox(height: 4), // Small spacing
                            Text(
                              'Status: ${_getCounterStatusText(descLength)}', 
                              style: GoogleFonts.cabin(color: counterColor, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // --- Dropdowns Row ---
                        _buildLabel("Priority & Status"), 
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Priority Dropdown with Flags
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Priority>(
                                    value: _selectedPriority,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    items: Priority.values.map((p) {
                                      return DropdownMenuItem(
                                        value: p,
                                        child: Row(
                                          children: [
                                            // Flag Icon
                                            Icon(_getPriorityIcon(p), color: _getPriorityColor(p), size: 20),
                                            const SizedBox(width: 10),
                                            Text(
                                              p.name.toUpperCase(),
                                              style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (v) => setState(() => _selectedPriority = v!),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Status Dropdown with Better Icons
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Status>(
                                    value: _selectedStatus,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                                    items: Status.values.map((s) {
                                      return DropdownMenuItem(
                                        value: s,
                                        child: Row(
                                          children: [
                                            // Status Icon
                                            Icon(_getStatusIcon(s), color: _getStatusColor(s), size: 20),
                                            const SizedBox(width: 10),
                                            Text(
                                              s.name == 'toDo' ? 'To Do' : s.name == 'inProgress' ? 'In Progress' : 'Done',
                                              style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (v) => setState(() => _selectedStatus = v!),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // --- Main Action Button ---
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isSaveDisabled() ? null : _saveTask,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C5CE7), // Vibrant Purple
                              foregroundColor: Colors.white,
                              elevation: 4,
                              shadowColor: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: Text(
                              widget.task == null ? 'Create Task' : 'Update Task',
                              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600]),
    );
  }
}