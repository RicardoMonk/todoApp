import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/project_model.dart';

class StorageService {
  static const String _key = 'user_projects';

  // GUARDAR: Convierte la lista de proyectos a JSON y la guarda
  Future<void> saveProjects(List<ProjectModel> projects) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(projects.map((p) => p.toJson()).toList());
    await prefs.setString(_key, data);
  }

  // CARGAR: Lee el JSON y lo convierte de vuelta a objetos de Dart
  Future<List<ProjectModel>?> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return null;

    final List decoded = jsonDecode(data);
    return decoded.map((p) => ProjectModel.fromJson(p)).toList();
  }
}
