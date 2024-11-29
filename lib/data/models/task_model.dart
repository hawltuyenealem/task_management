class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      dueDate: json["dueDate"],
      priority: json['priority'],
      isCompleted: json['isCompleted']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dueDate": dueDate,
        "priority": priority,
        "isCompleted": isCompleted
      };
}

extension TaskCategory on TaskModel {
  bool isToday() {
    final now = DateTime.now();
    return dueDate.year == now.year &&
        dueDate.month == now.month &&
        dueDate.day == now.day;
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dueDate.year == tomorrow.year &&
        dueDate.month == tomorrow.month &&
        dueDate.day == tomorrow.day;
  }

  bool isThisWeek() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return dueDate.isAfter(weekStart) && dueDate.isBefore(weekEnd);
  }
}
