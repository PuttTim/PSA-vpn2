
import 'package:flutter/material.dart';

class EmptyTasksWdget extends StatelessWidget {
  const EmptyTasksWdget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            child: Icon(
              Icons.check,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "There are no tasks to be done.",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
