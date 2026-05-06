import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme/app_colors.dart';
import '../providers/projects_provider.dart';
import '../widgets/project_card.dart';
import '../widgets/progress_painter.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showCreateProjectSheet(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();

    final List<IconData> availableIcons = [
      Icons.code,
      Icons.terminal,
      Icons.storage,
      Icons.smartphone,
      Icons.cloud,
      Icons.psychology,
      Icons.fitness_center,
      Icons.menu_book,
      Icons.web,
      Icons.security,
      Icons.analytics,
      Icons.settings_ethernet,
      Icons.architecture,
      Icons.science,
      Icons.rocket_launch,
      Icons.bolt,
    ];

    final List<Color> availableColors = [
      const Color(0xFF6200EE),
      const Color(0xFF02539A),
      const Color(0xFF00C853),
      const Color(0xFFFF5252),
      const Color(0xFFFFAB00),
      const Color(0xFF00B8D4),
      const Color(0xFFE91E63),
      const Color(0xFF455A64),
    ];

    IconData selectedIcon = availableIcons[0];
    Color selectedColor = availableColors[0];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
                  'Nuevo Tema de Estudio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Nombre del tema (ej. Azure, Python...)',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Selecciona un icono',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: availableIcons.length,
                    itemBuilder: (context, index) {
                      final icon = availableIcons[index];
                      final isSelected = selectedIcon == icon;
                      return GestureDetector(
                        onTap: () => setModalState(() => selectedIcon = icon),
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? selectedColor
                                : Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icon,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        ref
                            .read(projectsProvider.notifier)
                            .createProject(
                              nameController.text,
                              selectedIcon,
                              selectedColor,
                            );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Crear Categoría',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectsProvider);
    final totalProgress = ref.watch(totalProgressProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buen día humano, ¿Cómo vamos?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6C6C6C),
                          ),
                        ),
                        Text(
                          '¡Tú puedes!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(70, 70),
                          painter: ProgressPainter(
                            progress: totalProgress,
                            color: AppColors.primaryRed,
                          ),
                        ),
                        Text(
                          '${(totalProgress * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Progreso Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sigue así con tus estudios.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: ReorderableSliverGridView(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85,
                onReorder: (oldIndex, newIndex) {
                  ref
                      .read(projectsProvider.notifier)
                      .reorderProjects(oldIndex, newIndex);
                },
                children: projects.map((project) {
                  return ProjectCard(
                    key: ValueKey(project.id),
                    project: project,
                    onTap: () {
                      // Aseguramos que la navegación use los argumentos correctos
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: project,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryRed,
        onPressed: () => _showCreateProjectSheet(context, ref),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
