import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  final String header;
  final String labelWhenEmpty;
  final List<TaskModel> taskList;

  const TaskListView({
    Key? key,
    required this.header,
    required this.labelWhenEmpty,
    required this.taskList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            header,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Visibility(
          visible: taskList.isEmpty,
          child: Container(
            padding: const EdgeInsets.only(left: 18, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              labelWhenEmpty,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Column(
          children: taskList.map((e) => TaskItem(taskModel: e)).toList(),
        ),
      ],
    );
  }
}
