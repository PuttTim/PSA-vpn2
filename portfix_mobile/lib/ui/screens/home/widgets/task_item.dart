import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/screens/details/details_screen.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItem({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Map<int, Color> colors = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    var isOverDue = widget.taskModel.dueDate.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch;

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors[widget.taskModel.priority]!.withAlpha(150),
                colors[widget.taskModel.priority]!.withAlpha(255),
              ],
            ),
          ),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
            ),
            child: ScrollOnExpand(
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  tapBodyToCollapse: true,
                  tapBodyToExpand: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isOverDue
                        ? "${widget.taskModel.title}(OVERDUE)"
                        : widget.taskModel.title,
                    style: const TextStyle(fontSize: 23),
                  ),
                ),
                collapsed: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM y')
                          .format(widget.taskModel.dueDate.toDate()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.taskModel.equipmentId)
                  ],
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [Text(widget.taskModel.equipmentId)],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.taskModel.description),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailsScreen(taskModel: widget.taskModel),
                          ),
                        ),
                        child: const Text("More Details"),
                      ),
                    ),
                  ],
                ),
                builder: (_, collapsed, expanded) => Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
