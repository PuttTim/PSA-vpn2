import 'package:portfix_mobile/data/tasks/task_dao.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';

class TaskDaoImpl implements TaskDao {
  TaskDaoImpl._();
  static final TaskDaoImpl _impl = TaskDaoImpl._();
  factory TaskDaoImpl.getInstance() => _impl;

  @override
  Future<void> deleteTask(String id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Stream<List<TaskModel>> getTaskStreams() {
    // TODO: implement getTaskStreams
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getTasksFuture() {
    // TODO: implement getTasksFuture
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(TaskModel task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
