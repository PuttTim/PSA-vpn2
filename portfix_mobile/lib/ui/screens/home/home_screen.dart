import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/data/tasks/task_repository.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/task_item.dart';
import 'package:shimmer/shimmer.dart';

import 'package:portfix_mobile/ui/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskRepository _repository = TaskRepository.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: StreamBuilder<List<TaskModel>>(
          stream: _repository.getTaskStreams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                period: const Duration(seconds: 1),
                child: Column(
                  children: [
                    loadingTile(context),
                    loadingTile(context),
                    loadingTile(context),
                  ],
                ),
                baseColor: CustomTheme.getbaseColor(context).withAlpha(90),
                highlightColor:
                    CustomTheme.gethighlightColor(context).withAlpha(120),
              );
            }
            if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
              // show empty screen
              return Container();
            }
            var inProgressList = snapshot.data!
                .where((element) => element.engineerId?.isNotEmpty == true)
                .toList();
            inProgressList.sort((a, b) {
              if (a.dueDate.millisecondsSinceEpoch >
                  b.dueDate.millisecondsSinceEpoch) return 1;
              return -1;
            });

            var others = snapshot.data!
                .where((element) => element.engineerId?.isNotEmpty == false)
                .toList();

            others.sort((a, b) {
              if (a.dueDate.millisecondsSinceEpoch >
                  b.dueDate.millisecondsSinceEpoch) return 1;
              return -1;
            });

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "In Progress",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Column(
                      children: inProgressList
                          .map((e) => TaskItem(taskModel: e))
                          .toList(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Others",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Column(
                      children:
                          others.map((e) => TaskItem(taskModel: e)).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ListTile loadingTile(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: CustomTheme.getbaseColor(context),
      ),
      title: Container(
        height: 20,
        color: CustomTheme.getbaseColor(context),
      ),
      subtitle: Container(
        height: 15,
        color: CustomTheme.getbaseColor(context),
      ),
    );
  }
}
