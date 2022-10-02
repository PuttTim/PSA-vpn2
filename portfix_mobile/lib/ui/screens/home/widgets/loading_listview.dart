import 'package:flutter/material.dart';
import 'package:portfix_mobile/ui/theme.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListView extends StatelessWidget {
  const LoadingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 1),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
            ),
            child: Container(
              color: CustomTheme.getbaseColor(context),
              height: 90,
            ),
          ),
        ),
        itemCount: 10,
      ),
      baseColor: CustomTheme.getbaseColor(context).withAlpha(90),
      highlightColor: CustomTheme.gethighlightColor(context).withAlpha(120),
    );
  }
}
