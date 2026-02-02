// [INSTRUCTION] Requirement: "Each task must have: title, description, priority, status"
// [CHANGEABLE] You can add extra methods (like copyWith or toString), but DO NOT remove these fields.

enum Priority { low, medium, high }

enum Status { toDo, inProgress, done }

class Task {
  String id; // [INSTRUCTION] Needed for unique identification (Delete/Update)
  String title; // [INSTRUCTION] Required Field
  String description; // [INSTRUCTION] Required Field
  Priority priority; // [INSTRUCTION] Required Field (Enum)
  Status status; // [INSTRUCTION] Required Field (Enum)

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });
}
