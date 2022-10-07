import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/empty_task.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/loading_listview.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/task_listview.dart';
import 'package:portfix_mobile/ui/screens/screens.dart';

import 'package:portfix_mobile/ui/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskRepository _repository = TaskRepository.getInstance();
  final EngineerRepository _engineerRepo = EngineerRepository.getInstance();
  final AuthRepository _authRepository = AuthRepository.getInstance();

  String name = "";

  @override
  void initState() {
    super.initState();
    (() async {
      var engineer = await _engineerRepo.getEngineerById(
        AuthRepository.getInstance().getCurrentUser()!.uid,
      );
      setState(() {
        name = engineer.name.split(' ')[0];
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $name"),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              AuthRepository.getInstance().logOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: _repository.getTaskStreams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingListView();
          }
          if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
            return const EmptyTasksWdget();
          }

          var inProgressList = snapshot.data!.where(isInProgress).toList()
            ..sort(sortByTime);

          var notStarted = snapshot.data!.where(isNotStarted).toList()
            ..sort(sortByTime);

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                TaskListView(
                  header: "In Progress",
                  labelWhenEmpty:
                      "There are no tasks in progress now. Try doing it now!",
                  taskList: inProgressList,
                ),
                const SizedBox(
                  height: 10,
                ),
                TaskListView(
                  header: "Not Started",
                  labelWhenEmpty: "There are no other tasks available",
                  taskList: notStarted,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int sortByTime(TaskModel a, TaskModel b) {
    if (a.dueDate.millisecondsSinceEpoch > b.dueDate.millisecondsSinceEpoch) {
      return 1;
    }
    return -1;
  }

  bool isInProgress(TaskModel task) {
    return task.engineerId == _authRepository.getCurrentUser()!.uid;
  }

  bool isNotStarted(TaskModel task) {
    return task.engineerId?.isNotEmpty == false;
  }
}
