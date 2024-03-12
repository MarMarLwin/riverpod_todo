import 'package:flutter/material.dart';
import 'package:riverpod_todo/common_widgets/primary_button.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(
        Sizes.p16,
      ),
      child: Column(
        children: [
          Text(message, style: Theme.of(context).textTheme.bodyLarge),
          gapH8,
          PrimaryButton(text: 'Go Home'.hardcoded)
        ],
      ),
    ));
  }
}
