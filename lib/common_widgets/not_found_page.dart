import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common_widgets/error_message_widget.dart';
import 'package:riverpod_todo/common_widgets/primary_button.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';
import 'package:riverpod_todo/routing/app_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ErrorMessageWidget('404- Not found'.hardcoded),
              gapH8,
              PrimaryButton(
                text: 'Go Home'.hardcoded,
                onPressed: () => context.goNamed(AppRoute.home.name),
              )
            ],
          ),
        ));
  }
}
