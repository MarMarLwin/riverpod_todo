import 'package:flutter/material.dart';
import 'package:riverpod_todo/constants/breakpoints.dart';

class ResponsiveTwoColumnLayout extends StatelessWidget {
  const ResponsiveTwoColumnLayout(
      {super.key,
      required this.startContent,
      required this.endContent,
      this.startFlex = 1,
      this.endFlex = 1,
      this.breakpoint = Breakpoint.tablet,
      required this.spacing,
      this.rowMainAxisAlignment = MainAxisAlignment.start,
      this.rowCrossAxisAlignment = CrossAxisAlignment.start,
      this.columnMainAxisAlignment = MainAxisAlignment.start,
      this.columnCrossAxisAlignment = CrossAxisAlignment.stretch});
  final Widget startContent;
  final Widget endContent;
  final int startFlex;
  final int endFlex;
  final double breakpoint;
  final double spacing;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth >= breakpoint) {
        return Row(
          mainAxisAlignment: rowMainAxisAlignment,
          crossAxisAlignment: rowCrossAxisAlignment,
          children: [
            Flexible(
              flex: startFlex,
              child: startContent,
            ),
            SizedBox(
              width: spacing,
            ),
            Flexible(
              flex: endFlex,
              child: endContent,
            )
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: columnMainAxisAlignment,
          crossAxisAlignment: columnCrossAxisAlignment,
          children: [
            startContent,
            SizedBox(
              height: spacing,
            ),
            endContent
          ],
        );
      }
    });
  }
}
