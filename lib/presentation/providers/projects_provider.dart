import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../domain/models/project_model.dart';
import '../../domain/models/task_model.dart';
import '../../shared/services/storage_service.dart'; // Importamos el servicio

class ProjectsNotifier extends StateNotifier<List<ProjectModel>> {
  final StorageService _storage = StorageService();

  ProjectsNotifier() : super([]) {
    _init(); // Intentamos cargar datos al arrancar
  }

  // Carga inicial desde el disco duro del Moto G
  Future<void> _init() async {
    final savedProjects = await _storage.loadProjects();
    if (savedProjects != null) {
      state = savedProjects;
    } else {
      state = _initialProjects; // Si es la primera vez, usa los datos base
    }
  }

  // Modificamos el toggle para que guarde automáticamente
  void toggleTask(String projectId, String taskId) {
    state = [
      for (final project in state)
        if (project.id == projectId)
          ProjectModel(
            id: project.id,
            name: project.name,
            icon: project.icon,
            color: project.color,
            tasks: [
              for (final task in project.tasks)
                if (task.id == taskId)
                  TaskModel(
                    id: task.id,
                    title: task.title,
                    isCompleted: !task.isCompleted,
                  )
                else
                  task,
            ],
          )
        else
          project,
    ];

    // PERSISTENCIA: Guardamos el nuevo estado en el disco
    _storage.saveProjects(state);
  }

  void createProject(String name, IconData icon, Color color) {
    final newProject = ProjectModel(
      id: DateTime.now().toString(),
      name: name,
      icon: icon,
      color: color,
      tasks: [], // Inicia con 0 tareas
    );

    state = [...state, newProject];
    _storage.saveProjects(state);
  }

  void addTask(String projectId, String title) {
    state = [
      for (final project in state)
        if (project.id == projectId)
          ProjectModel(
            id: project.id,
            name: project.name,
            icon: project.icon,
            color: project.color,
            tasks: [
              ...project.tasks,
              TaskModel(
                id: DateTime.now().toString(), // ID único basado en tiempo
                title: title,
              ),
            ],
          )
        else
          project,
    ];

    // Guardamos inmediatamente en el disco
    _storage.saveProjects(state);
  }

  void reorderProjects(int oldIndex, int newIndex) {
    final List<ProjectModel> newList = [...state];
    final item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);

    state = newList;
    _storage.saveProjects(state); // Persistencia inmediata del nuevo orden
  }

  static final List<ProjectModel> _initialProjects = [
    ProjectModel(
      id: '1',
      name: 'Ingeniería .NET',
      icon: Icons.terminal,
      color: const Color(0xFF6200EE),
      tasks: [
        TaskModel(id: '101', title: 'Revisar Inyección de Dependencias'),
        TaskModel(id: '102', title: 'Configurar Middleware .NET 8'),
      ],
    ),

    ProjectModel(
      id: '2',
      name: 'Desarrollo Flutter',
      icon: Icons.smartphone,
      color: const Color(0xFF02539A),
      tasks: [],
    ),

    ProjectModel(
      id: '3',
      name: 'Arquitectura SQL',
      icon: Icons.storage,
      color: const Color(0xFF00C853),
      tasks: [],
    ),

    ProjectModel(
      id: '4',
      name: 'Boxing Tech',
      icon: Icons.fitness_center,
      color: const Color(0xFFFF5252),
      tasks: [],
    ),
  ];

  void deleteProject(String projectId) {
    // Filtramos la lista para quitar el proyecto con ese ID
    state = state.where((project) => project.id != projectId).toList();

    // Guardamos los cambios en el disco duro del Moto G
    _storage.saveProjects(state);
  }
}

final projectsProvider =
    StateNotifierProvider<ProjectsNotifier, List<ProjectModel>>((ref) {
      return ProjectsNotifier();
    });

final totalProgressProvider = Provider<double>((ref) {
  final projects = ref.watch(projectsProvider);
  if (projects.isEmpty) return 0.0;

  int totalTasks = 0;
  int completedTasks = 0;

  for (var project in projects) {
    totalTasks += project.tasks.length;
    completedTasks += project.tasks.where((t) => t.isCompleted).length;
  }

  return totalTasks == 0 ? 0.0 : completedTasks / totalTasks;
});
