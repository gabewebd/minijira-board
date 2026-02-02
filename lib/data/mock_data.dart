import '../models/task.dart';

final List<Task> mockTasks = [
  Task(
    id: '1',
    title: 'Fix login bug',
    description: 'Users cannot login on mobile devices when using cellular data.',
    priority: Priority.high,
    status: Status.toDo,
  ),
];