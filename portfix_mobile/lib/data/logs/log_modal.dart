import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';

class LogModel {
  String? id;
  String title;
  String engineerId;
  String equipmentId;
  Timestamp timestamp;
  String comment;
  String type;

  LogModel({
    this.id,
    required this.title,
    required this.engineerId,
    required this.equipmentId,
    required this.timestamp,
    required this.comment,
    required this.type,
  });

  LogModel.fromTask({
    String? id,
    required TaskModel task,
    required String comment,
    required String type,
  }) : this(
          id: id,
          title: task.title,
          engineerId: task.engineerId!,
          equipmentId: task.equipmentId,
          timestamp: Timestamp.now(),
          comment: comment,
          type: type,
        );

  LogModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc)
      : this(
          id: doc.id,
          comment: doc["comment"],
          engineerId: doc["engineerId"],
          equipmentId: doc["equipmentId"],
          timestamp: doc["timestamp"],
          title: doc["title"],
          type: doc["type"],
        );

  Map<String, dynamic> toMap() {
    return {
      "comment": comment,
      "engineerId": engineerId,
      "equipmentId": equipmentId,
      "timestamp": timestamp,
      "title": title,
      "type": type,
    };
  }
}

class LogType {
  static const String cancelled = "Cancelled";
  static const String completed = "Completed";
}
