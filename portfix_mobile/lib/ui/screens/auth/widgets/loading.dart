import 'package:flutter/material.dart';
import 'package:portfix_mobile/ui/theme.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  const LoadingWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: CustomTheme.primary.shade100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
