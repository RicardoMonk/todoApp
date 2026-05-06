class TaskModel {
  final String id;
  final String title;
  bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});

  // Convertir a Mapa para guardar
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
  };

  // Crear desde Mapa al leer del disco
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'],
    title: json['title'],
    isCompleted: json['isCompleted'],
  );
}
