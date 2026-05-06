import 'package:flutter/material.dart';
import '../../domain/models/task_model.dart';
import '../../shared/theme/app_colors.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskItem({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onToggle,
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : AppColors.textSecondary,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted
                ? AppColors.textSecondary
                : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
