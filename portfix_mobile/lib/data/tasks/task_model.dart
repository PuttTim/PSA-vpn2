import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String priority;
  int repeat;
  String description;
  String? assignedId;
  Status status;
  DateTime lastDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.priority,
    required this.repeat,
    required this.description,
    required this.status,
    required this.lastDone,
    this.assignedId,
  });

  TaskModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc)
      : this(
          id: doc.id,
          title: doc["title"],
          priority: doc["priority"],
          repeat: doc["repeat"],
          description: doc["description"],
          lastDone: DateTime.fromMillisecondsSinceEpoch(doc["lastDone"]),
          status: Status.values[doc["status"]],
          assignedId: doc["assignedId"] ?? "",
        );
}

enum Status {
  notStarted,
  inProgress,
  completed,
}
