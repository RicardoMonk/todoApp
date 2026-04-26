import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/project_model.dart';

// Este provider expondrá tus categorías de estudio reales
final projectsProvider = Provider<List<ProjectModel>>((ref) {
  return [
    ProjectModel(
      id: '1',
      name: 'Ingeniería .NET',
      icon: Icons.terminal,
      color: const Color(0xFF6200EE), // Un morado tecnológico
      tasks: [],
    ),
    ProjectModel(
      id: '2',
      name: 'Desarrollo Flutter',
      icon: Icons.smartphone,
      color: const Color(0xFF02539A), // Azul Flutter
      tasks: [],
    ),
    ProjectModel(
      id: '3',
      name: 'Arquitectura SQL',
      icon: Icons.storage,
      color: const Color(0xFF00C853), // Verde base de datos
      tasks: [],
    ),
    ProjectModel(
      id: '4',
      name: 'Boxing Tech',
      icon: Icons.fitness_center,
      color: const Color(0xFFFF5252), // Rojo energía
      tasks: [],
    ),
  ];
});
