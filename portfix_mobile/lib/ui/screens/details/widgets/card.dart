import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double width;
  final String title;
  final String content;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;

  const CardWidget({
    Key? key,
    required this.width,
    required this.title,
    required this.content,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 1,
    ),
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        color: Theme.of(context).colorScheme.primary.withAlpha(70),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
