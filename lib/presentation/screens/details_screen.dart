import 'package:flutter/material.dart';
import '../../domain/models/project_model.dart';
import '../../shared/theme/app_colors.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibimos el proyecto enviado a través de los argumentos de la ruta
    final project = ModalRoute.of(context)!.settings.arguments as ProjectModel;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          project.name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header de la categoría
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: project.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(project.icon, color: project.color, size: 40),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progreso de estudio',
                      style: TextStyle(
                        color: project.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(project.progress * 100).toInt()}% completado',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Aquí irán las tareas (Próximo paso)
          const Expanded(
            child: Center(child: Text('Próximamente: Lista de Tareas')),
          ),
        ],
      ),
    );
  }
}
