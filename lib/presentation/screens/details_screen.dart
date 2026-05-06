import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/project_model.dart';
import '../../shared/theme/app_colors.dart';
import '../providers/projects_provider.dart';
import '../widgets/task_item.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({super.key});

  // Esta es la función que estaba "dormida"
  void _showAddTaskSheet(
    BuildContext context,
    WidgetRef ref,
    String projectId,
    Color color,
  ) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nueva Tarea de Estudio',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Ej. Estudiar herencia en C#',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ref
                          .read(projectsProvider.notifier)
                          .addTask(projectId, controller.text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Guardar Tarea',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectArg =
        ModalRoute.of(context)!.settings.arguments as ProjectModel;
    final projects = ref.watch(projectsProvider);
    final project = projects.firstWhere((p) => p.id == projectArg.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          project.name,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Header del Proyecto (Asegúrate de que este widget exista o esté aquí)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: project.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // SOLO ESTE HERO: Elimina el Icon que estaba afuera
                  Hero(
                    tag: 'icon_${project.id}',
                    child: Icon(project.icon, color: project.color, size: 40),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ruta de aprendizaje activada',
                          style: TextStyle(color: project.color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: project.tasks.length,
                itemBuilder: (context, index) {
                  final task = project.tasks[index];
                  return TaskItem(
                    task: task,
                    onToggle: () {
                      ref
                          .read(projectsProvider.notifier)
                          .toggleTask(project.id, task.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ESTE ES EL PUNTO 3: El botón que llama a la función
      floatingActionButton: FloatingActionButton(
        backgroundColor: project.color,
        onPressed: () =>
            _showAddTaskSheet(context, ref, project.id, project.color),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
