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

              return Expanded(
                child: ListView.separated(
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
                ),
              );
            },
          )
        ],
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
