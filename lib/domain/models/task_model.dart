class TaskModel {
  final String id;
  final String title;
  bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});
}
