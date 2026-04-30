import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  final String title;
  final String description;
  bool isDone;
  final int createdAt; 
  final int priority;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.priority,
  });

  /// 🔥 تحويل لـ Firebase
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
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      isDone: json["isDone"] ?? false,
      priority: json["priority"] ?? 1,

      
      createdAt: json["createdAt"] is Timestamp
          ? (json["createdAt"] as Timestamp).millisecondsSinceEpoch
          : json["createdAt"] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  DateTime get createdDate {
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  String get formattedDate {
    final date = createdDate;
    return "${date.day}/${date.month}/${date.year} - "
        "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}