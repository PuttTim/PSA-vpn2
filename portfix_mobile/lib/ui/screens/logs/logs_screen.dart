import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/logs/log_modal.dart';

class LogsScreen extends StatefulWidget {
  final LogModel inCompleteLog;

  const LogsScreen({
    Key? key,
    required this.inCompleteLog,
  }) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
