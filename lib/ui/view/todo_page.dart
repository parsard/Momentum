import 'package:flutter/material.dart';
import 'package:momentum/viewModel/todo_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:momentum/core/constants/app_colors.dart';
import 'package:momentum/ui/widgets/add_button.dart';
import 'package:momentum/ui/widgets/footer.dart';
import 'package:momentum/ui/widgets/task_card.dart'; // A task card for displaying individual tasks

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoPageViewmodel>(
      child: const Stack(children: [AddButton(), AppFooter()]),
      builder: (context, todoViewModel, child) {
        final tasks = todoViewModel.tasks;

        return Scaffold(
          backgroundColor: AppColors.green_50,
          body: Stack(
            children: [
              if (tasks.isEmpty) ...[
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/todoPage/wome-men.png', height: 250),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          todoViewModel.addTask(
                            title: 'Your First Task',
                          ); // Example task
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.myOrange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          'Click here to create your first task.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Mulish',
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TaskCard(
                              task: task,
                              onToggleDone:
                                  () => todoViewModel.toggleDone(index),
                              onToggleFavorite:
                                  () => todoViewModel.toggleFavorite(index),
                              onDelete: () => todoViewModel.removeTask(index),
                              onNameChange:
                                  (newName) => todoViewModel.updateTaskName(
                                    index,
                                    newName,
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (child != null) child,
            ],
          ),
        );
      },
    );
  }
}
