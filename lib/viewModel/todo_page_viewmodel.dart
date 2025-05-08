import 'package:flutter/material.dart';
import 'package:momentum/model/task.dart'; // Assuming your Task model exists here

class TodoPageViewmodel extends ChangeNotifier {
  final List<Task> _tasks = [];

  // Getter for tasks
  List<Task> get tasks => List.unmodifiable(_tasks);

  /// Add a new task
  void addTask({required String title}) {
    final newTask = Task(id: DateTime.now().toIso8601String(), title: title);
    _tasks.insert(0, newTask); // Add new task on top
    notifyListeners();
  }

  // Remove a task
  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  // Toggle task completion
  void toggleDone(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }

  // Toggle favorite
  void toggleFavorite(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isFavorite = !_tasks[index].isFavorite;
      notifyListeners();
    }
  }

  // Update task name
  void updateTaskName(int index, String newName) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].title = newName;
      notifyListeners();
    }
  }
}
