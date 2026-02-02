import '../models/task.dart';

// Requirement: may 6 sample tasks
// Pwede pang baguhin, pang-StudySprint
final List<Task> mockTasks = [
  Task(
    id: '1',
    title: 'Finish Mobile Dev Lab',
    description: 'Complete the Flutter UI layout and push code to GitHub.',
    priority: Priority.high,
    status: Status.inProgress,
  ),
  Task(
    id: '2',
    title: 'Review History Notes',
    description: 'Read chapters 4-5 for the upcoming midterm exam.',
    priority: Priority.medium,
    status: Status.toDo,
  ),
  Task(
    id: '3',
    title: 'Buy Group Snacks',
    description: 'Get chips and soda for the hackathon tonight.',
    priority: Priority.low,
    status: Status.done,
  ),
  Task(
    id: '4',
    title: 'Email Professor',
    description:
        'Ask for clarification on the final project rubric requirements.',
    priority: Priority.medium,
    status: Status.toDo,
  ),
  Task(
    id: '5',
    title: 'Print Research Paper',
    description: 'Print the final draft of the Ethics essay at the library.',
    priority: Priority.high,
    status: Status.done,
  ),
  Task(
    id: '6',
    title: 'Update Resume',
    description: 'Add the new Flutter project to the portfolio section.',
    priority: Priority.low,
    status: Status.inProgress,
  ),
];
