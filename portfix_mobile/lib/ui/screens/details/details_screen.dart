import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/data/equipment/equipment_model.dart';
import 'package:portfix_mobile/data/logs/log_modal.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/screens/details/widgets/card.dart';
import 'package:portfix_mobile/ui/screens/details/widgets/google_map.dart';
import 'package:portfix_mobile/ui/screens/logs/logs_screen.dart';
import 'package:portfix_mobile/ui/theme.dart';

class DetailsScreen extends StatefulWidget {
  final TaskModel taskModel;
  const DetailsScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final EquipmentRepository _equipmentRepo = EquipmentRepository.getInstance();
  final EngineerRepository _engineerRepo = EngineerRepository.getInstance();
  final TaskRepository _taskRepository = TaskRepository.getInstance();
  final AuthRepository _authRepository = AuthRepository.getInstance();
  String? name;

  Map<int, String> priorityMap = {
    1: "Low",
    2: "Medium",
    3: "High",
  };

  @override
  void initState() {
    super.initState();
    (() async {
      if (widget.taskModel.status == Status.inProgress) {
        var engineer = await _engineerRepo.getEngineerById(
          widget.taskModel.engineerId!,
        );
        setState(() {
          name = engineer.name;
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var alreadyAssigned = widget.taskModel.engineerId != null &&
        widget.taskModel.status == Status.inProgress;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskModel.title + " (${widget.taskModel.equipmentId})",
        ),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
      ),
      body: FutureBuilder<EquipmentModel>(
        future: _equipmentRepo.getEquipmentById(
          widget.taskModel.equipmentId,
        ),
        builder: (context, equipmentSnapshot) {
          if (equipmentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                MapWidget(
                  equipmentModel: equipmentSnapshot.data!,
                ),
                const SizedBox(height: 5),
                CardWidget(
                  width: double.infinity,
                  title: "Priority",
                  content: priorityMap[widget.taskModel.priority]!,
                ),
                Row(
                  children: [
                    CardWidget(
                      width: (width / 2) - 19,
                      title: "Due Date",
                      content: DateFormat('dd MMM y')
                          .format(widget.taskModel.dueDate.toDate())
                          .toString(),
                      padding: const EdgeInsets.only(
                        top: 1,
                        bottom: 1,
                        right: 1,
                        left: 10,
                      ),
                    ),
                    CardWidget(
                      width: (width / 2) - 19,
                      title: "Status",
                      content: widget.taskModel.status,
                      padding: const EdgeInsets.only(
                        top: 1,
                        bottom: 1,
                        right: 10,
                        left: 1,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: name != null,
                  child: CardWidget(
                    width: double.infinity,
                    title: "Assigned to",
                    content: name ?? "",
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                CardWidget(
                  width: double.infinity,
                  title: "Description",
                  content: widget.taskModel.description,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                getButtons(alreadyAssigned),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getButtons(bool alreadyAssigned) {
    if (alreadyAssigned) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.red,
                ),
                onPressed: () async {
                  var inCompleteLog = LogModel.fromTask(
                    task: widget.taskModel,
                    type: LogType.cancelled,
                  );
                  await cancelTask();
                  navigateToLogsScreen(inCompleteLog);
                },
                child: const Text("Cancel"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () async {
                  var inCompleteLog = LogModel.fromTask(
                    task: widget.taskModel,
                    type: LogType.completed,
                  );
                  await completeTask();
                  navigateToLogsScreen(inCompleteLog);
                },
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 0),
        onPressed: () => assignTaskToCurrentUser(),
        child: const Text("I will be doing this!"),
      ),
    );
  }

  void navigateToLogsScreen(LogModel inCompleteLog) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LogsScreen(
          inCompleteLog: inCompleteLog,
        ),
      ),
    );
  }

  Future<void> cancelTask() async {
    widget.taskModel.cancel();
    await _taskRepository.updateTask(widget.taskModel);
  }

  Future<void> completeTask() async {
    if (widget.taskModel.complete()) {
      await _taskRepository.deleteTask(widget.taskModel.id);
      return;
    }
    await _taskRepository.updateTask(widget.taskModel);
  }

  void assignTaskToCurrentUser() async {
    widget.taskModel.assignToUser(_authRepository.getCurrentUser()!.uid);
    await _taskRepository.updateTask(widget.taskModel);
    Navigator.of(context).pop();
  }
}
