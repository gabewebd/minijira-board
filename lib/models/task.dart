enum Priority { low, medium, high }

enum Status { toDo, inProgress, done }

class Task {
  String id;
  String title;
  String description;
  Priority priority;
  Status status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });

  // Optional: toString, copyWith, etc. for convenience
  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, priority: $priority, status: $status)';
  }
}