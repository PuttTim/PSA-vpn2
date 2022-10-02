import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfix_mobile/ui/theme.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveHeader extends StatelessWidget {
  final String title;
  const WaveHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: pi,
          child: WaveWidget(
            config: CustomConfig(
              durations: [4000],
              heightPercentages: [0],
              gradientBegin: Alignment.centerLeft,
              gradientEnd: Alignment.centerRight,
              gradients: [
                [CustomTheme.primary.withGreen(130), CustomTheme.primary]
              ],
            ),
            size: Size(
              double.infinity,
              MediaQuery.of(context).size.height * 0.5,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        )
      ],
    );
  }
}
