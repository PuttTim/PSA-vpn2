import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfix_mobile/data/tasks/task_dao.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';

class TaskRepository implements TaskDao {
  TaskRepository._();
  static final TaskRepository _impl = TaskRepository._();
  factory TaskRepository.getInstance() => _impl;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collectionPath = "tasks";

  @override
  Stream<List<TaskModel>> getTaskStreams() {
    return _firestore.collection(collectionPath).snapshots().map((event) {
      return event.docs.map((doc) {
        return TaskModel.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future<List<TaskModel>> getTasksFuture() async {
    var tasks = await _firestore.collection(collectionPath).get();
    return tasks.docs.map((e) {
      return TaskModel.fromDocument(e);
    }).toList();
  }

  @override
  Future<bool> createTask(TaskModel task) async {
    try {
      await _firestore.collection(collectionPath).doc().set(task.toMap());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> updateTask(TaskModel task) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(task.id)
          .set(task.toMap());
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
