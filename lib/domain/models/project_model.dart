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

  // Cálculo del progreso (mantenemos esta lógica)
  double get progress {
    if (tasks.isEmpty) return 0.0;
    final completed = tasks.where((t) => t.isCompleted).length;
    return completed / tasks.length;
  }

  // CONVERTIR A JSON (Para guardar en el teléfono)
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon.codePoint, // Guardamos el código numérico del icono
    'color': color.toARGB32(), // Guardamos el valor entero del color
    'tasks': tasks.map((t) => t.toJson()).toList(), // Convertimos cada tarea
  };

  // CREAR DESDE JSON (Para leer del teléfono)
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
      // Aquí transformamos la lista de mapas de vuelta a objetos TaskModel
      tasks: (json['tasks'] as List)
          .map((taskJson) => TaskModel.fromJson(taskJson))
          .toList(),
    );
  }
}
