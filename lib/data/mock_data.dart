import '../models/task.dart';

// Requirement: may 6 sample tasks
// Pwede pang baguhin
final List<Task> mockTasks = [
  Task(
    id: '1',
    title: 'Fix Login Authentication',
    description: 'Users report getting a 403 Error when logging in via Google OAuth.',
    priority: Priority.high,
    status: Status.toDo,
  ),
  Task(
    id: '2',
    title: 'Design Dashboard UI',
    description: 'Create high-fidelity Figma mockups for the main analytics dashboard.',
    priority: Priority.medium,
    status: Status.inProgress,
  ),
  Task(
    id: '3',
    title: 'Setup Firebase Database',
    description: 'Initialize Firestore and configure security rules for user data.',
    priority: Priority.high,
    status: Status.done,
  ),
  Task(
    id: '4',
    title: 'Write API Documentation',
    description: 'Document the new endpoints for the mobile app team using Swagger.',
    priority: Priority.low,
    status: Status.inProgress,
  ),
  Task(
    id: '5',
    title: 'Refactor Profile Widget',
    description: 'Clean up the spaghetti code in the user profile section for better performance.',
    priority: Priority.low,
    status: Status.toDo,
  ),
  Task(
    id: '6',
    title: 'QA Testing - V1.2',
    description: 'Perform regression testing on the release candidate build.',
    priority: Priority.medium,
    status: Status.done,
  ),
];