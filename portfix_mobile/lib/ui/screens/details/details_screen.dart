import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/data/equipment/equipment_model.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/screens/details/widgets/card.dart';
import 'package:portfix_mobile/ui/screens/details/widgets/google_map.dart';
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
        title: Text(widget.taskModel.title),
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
                      width: (width / 2) - 28,
                      title: "Due Date",
                      content: DateFormat('dd MMM y')
                          .format(widget.taskModel.dueDate.toDate())
                          .toString(),
                    ),
                    CardWidget(
                      width: (width / 2) - 28,
                      title: "Status",
                      content: widget.taskModel.status,
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
                Visibility(
                  visible: !alreadyAssigned,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {},
                      child: const Text("I will be doing this!"),
                    ),
                  ),
                ),
                Visibility(
                  visible: alreadyAssigned,
                  child: Container(
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
                            onPressed: () {},
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            onPressed: () {},
                            child: const Text("Done"),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
