import '../data/models/task_model.dart';

final tasks = [
  TaskModel(
    id: "1",
    title: "Schedule dentist appointment",
    description: "Visit the dentist at 10:00 AM.",
    dueDate: DateTime.now(),
    priority: "High",
  ),
  TaskModel(
    id: "2",
    title: "Prepare Team Meeting",
    description: "Prepare slides and agenda for tomorrow's meeting.",
    dueDate: DateTime.now().add(const Duration(days: 1)),
    priority: "Medium",
  ),
  TaskModel(
    id: "3",
    title: "Submit exercise 3.1",
    description: "Complete and submit the exercise for the study group.",
    dueDate: DateTime.now().add(const Duration(days: 2)),
    priority: "Low",
  ),
];
