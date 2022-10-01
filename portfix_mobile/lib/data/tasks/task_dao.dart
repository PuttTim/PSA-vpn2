import 'package:portfix_mobile/data/tasks/task_model.dart';

abstract class TaskDao {
  Stream<List<TaskModel>> getTaskStreams();
  Future<List<TaskModel>> getTasksFuture();
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}
