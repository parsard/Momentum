import 'package:flutter/material.dart';
import 'package:momentum/model/task.dart';
import 'package:momentum/core/constants/app_colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleDone;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete;
  final ValueChanged<String> onNameChange;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleDone,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onNameChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(value: task.isDone, onChanged: (_) => onToggleDone()),
        title: TextFormField(
          initialValue: task.title,
          decoration: const InputDecoration(border: InputBorder.none),
          onFieldSubmitted: onNameChange,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(task.isFavorite ? Icons.star : Icons.star_border),
              color: AppColors.myOrange,
              onPressed: onToggleFavorite,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
