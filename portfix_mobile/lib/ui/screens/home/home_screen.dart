import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/data/tasks/task_repository.dart';
import 'package:portfix_mobile/ui/screens/home/widgets/task_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
        title: const Text("In Progress"),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
      ),
      body: Stack(
        children: [
          wave(context),
          StreamBuilder<List<TaskModel>>(
            stream: _repository.getTaskStreams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // show loading widget
                return Shimmer.fromColors(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(),
                        title: Container(height: 10),
                      ),
                      ListTile(
                        leading: const CircleAvatar(),
                        title: Container(height: 10),
                      ),
                      ListTile(
                        leading: const CircleAvatar(),
                        title: Container(height: 10),
                      ),
                    ],
                  ),
                  baseColor: CustomTheme.getbaseColor(context),
                  highlightColor: CustomTheme.gethighlightColor(context),
                );
              }
              if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                // show empty screen
                return Container();
              }

              return ListView.separated(
                itemBuilder: (ctx, i) {
                  return TaskItem(taskModel: snapshot.data![i]);
                },
                separatorBuilder: (ctx, i) {
                  return Container(
                    height: 1,
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(50),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            },
          )
        ],
      ),
    );
  }

  Widget wave(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: WaveWidget(
        config: CustomConfig(
          durations: [4000],
          heightPercentages: [0],
          gradientBegin: Alignment.topCenter,
          gradientEnd: Alignment.bottomCenter,
          gradients: [
            [CustomTheme.primary.withGreen(130), CustomTheme.primary]
          ],
        ),
        size: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.45,
        ),
      ),
    );
  }
}
