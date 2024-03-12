// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:riverpod_todo/common_widgets/responsive_center.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/constants/breakpoints.dart';

class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(Sizes.p48),
          child: child,
        )),
      ),
    ));
  }
}
