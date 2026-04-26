import 'package:flutter/material.dart';
import 'task_model.dart';

class ProjectModel {
  final String id;
  final String name;
  final IconData icon;
  final List<TaskModel> tasks;
  final Color color;

  ProjectModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.tasks,
    required this.color,
  });

  // Cálculo automático del progreso para tu círculo central
  double get progress {
    if (tasks.isEmpty) return 0.0;
    final completed = tasks.where((t) => t.isCompleted).length;
    return completed / tasks.length;
  }
}
