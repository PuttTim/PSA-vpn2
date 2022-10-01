import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String equipmentId;
  String title;
  int priority; /* 1, 2, 3 1 -> lowest priority */
  int repeat;
  String description;
  String? engineerId;
  String status;
  DateTime lastDone;

  TaskModel({
    required this.id,
    required this.equipmentId,
    required this.title,
    required this.priority,
    required this.repeat,
    required this.description,
    required this.status,
    required this.lastDone,
    this.engineerId,
  });

  TaskModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc)
      : this(
          id: doc.id,
          equipmentId: doc["equipmentId"],
          title: doc["title"],
          priority: doc["priority"],
          repeat: doc["repeat"],
          description: doc["description"],
          lastDone: DateTime.parse(doc["lastDone"]),
          status: doc["status"],
          engineerId: doc["engineerId"] ?? "",
        );

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "priority": priority,
      "repeat": repeat,
      "description": description,
      "lastDone": lastDone.toString(),
      "status": status,
      "engineerId": engineerId,
      "equipmentId": equipmentId,
    };
  }
}

class Status {
  static const String notStarted = "Not Started";
  static const String inProgress = "In Progress";
  static const String completed = "Completed";
}
