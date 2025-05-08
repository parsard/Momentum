class Task {
  String id; // Unique identifier for the task
  String title; // Task title
  bool isDone; // Whether the task is completed
  bool isFavorite; // Whether the task is marked as favorite

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });
}
