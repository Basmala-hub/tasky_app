import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final int priority;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.priority,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "isDone": isDone,
      "createdAt": createdAt,
      "priority": priority,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      title: json["title"],
      description: json["description"],
      isDone: json["isDone"],
      priority: json["priority"],
      createdAt: (json["createdAt"] as Timestamp).toDate(),
    );
  }
}