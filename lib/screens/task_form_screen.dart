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

  // Controllers para makuha yung input sa text fields
  late TextEditingController _titleController;
  late TextEditingController _descController;

  // Default values kung wala pang nakaset
  Priority _selectedPriority = Priority.low;
  Status _selectedStatus = Status.toDo;

  @override
  void initState() {
    super.initState();
    // Initialize muna yung controllers.
    // Kung may pinasang task (edit mode), gamitin yung values nun.
    // Kung wala (add mode), empty string lang.
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descController = TextEditingController(
      text: widget.task?.description ?? '',
    );

    // Check kung hindi null yung task, kopyahin yung existing priority at status
    if (widget.task != null) {
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
    }
  }

  @override
  void dispose() {
    // Need i-dispose para iwas memory leak pag sinara yung screen
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Helper function para sa kulay ng counter (Requirement B2)
  // Green pag safe pa, Yellow pag malapit na mapuno, Red pag danger na
  Color _getCounterColor(int length) {
    if (length <= 40) return AppColors.counterSafe;
    if (length <= 80) return AppColors.counterWarning;
    return AppColors.counterDanger;
  }

  // Etong text naman yung magbabago (Safe / Warning / Danger) depende sa haba
  String _getCounterText(int length) {
    if (length <= 40) return "Safe";
    if (length <= 80) return "Warning";
    return "Danger";
  }

  // Logic pag pinindot yung Save button
  void _saveTask() {
    // Validate muna kung tama lahat ng input bago mag proceed
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Task(
          // Kung may ID na (edit), retain lang. Kung wala, gawa bago gamit datetime
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
    // Kunin yung current length ng description para sa counter natin
    final int descLen = _descController.text.length;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        // Dynamic yung title depende kung nag-aadd or edit
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
              key: _formKey, // Importante to para sa validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Title / Subject Section ---
                  _buildLabel("Subject / Title"),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "E.g., Math Homework",
                    ),
                    // Bawal tong iwan na blanko
                    validator: (v) => v!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 20),

                  // --- Description / Details Section ---
                  _buildLabel("Details"),
                  TextFormField(
                    controller: _descController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Enter details...",
                    ),
                    // Need mag setState para mag-update yung counter real-time
                    onChanged: (v) => setState(() {}),

                    // Requirement: Bawal i-save kapag lumampas sa 120 characters
                    validator: (v) => v!.length > 120
                        ? "Too long!"
                        : (v.isEmpty ? "Required" : null),
                  ),
                  const SizedBox(height: 8),

                  // Dito banda yung character counter sa ilalim ng text area
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Display nung mismong count (e.g. 50/120)
                        Text(
                          "$descLen / 120",
                          style: TextStyle(
                            color: _getCounterColor(descLen),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Display nung status text
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

                  // --- Priority at Status Dropdowns ---
                  Row(
                    children: [
                      // Priority Dropdown (Low, Medium, High)
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

                      // Status Dropdown (To Do, Studying, Done)
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
                                        // Custom text display para mas user-friendly
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
                      // Disable yung button pag sobra sa 120 characters yung description
                      onPressed: descLen > 120 ? null : _saveTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
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

  // Reusable widget para sa labels para di paulit-ulit yung style
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
