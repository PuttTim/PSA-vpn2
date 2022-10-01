import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Map<int, Color> colors = {
    1: Colors.green,
    2: Colors.amber,
    3: Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors[widget.taskModel.priority],
      ),
      title: Text(widget.taskModel.title),
      subtitle: Text(
        DateFormat('dd MMM y')
            .format(widget.taskModel.dueDate.toDate())
            .toString(),
      ),
    );
  }
}
