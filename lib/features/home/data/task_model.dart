// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  TaskModel({
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.periority,
  });
  String title;
  String description;
  bool isDone;
  DateTime createdAt;
  int periority;
  Map<String, dynamic> tojson(TaskModel task) {
    return {
      "title": task.title,
      "description": task.description,
      "isDone": task.isDone,
      "createdAt": task.createdAt.toIso8601String(),
      "periority": task.periority,
    };
  }

  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        isDone: json["isDone"],
        periority: json["periority"],
        title: json["title"],
      );
}


void main() {
  final task = TaskModel(
    title: "Task 1",
    description: "This is the first task",
    isDone: false,
    createdAt: DateTime.now(),
    periority: 1,
  );

  final json = task.tojson(task);
  print(json);

  final newTask = TaskModel.fromJson(json);
  print(newTask.title);
}