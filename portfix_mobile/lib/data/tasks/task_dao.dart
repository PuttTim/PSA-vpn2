import 'package:portfix_mobile/data/tasks/task_model.dart';

abstract class TaskDao {
  Stream<List<TaskModel>> getTaskStreams();
  Future<List<TaskModel>> getTasksFuture();
  Future<bool> createTask(TaskModel task);
  Future<bool> updateTask(TaskModel task);
  Future<bool> deleteTask(String id);
}
