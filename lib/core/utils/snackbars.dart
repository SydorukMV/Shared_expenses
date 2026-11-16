import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context,
  String message, {
  bool isError = false,
}) {
  showMessengerSnackBar(
    ScaffoldMessenger.of(context),
    message,
    isError: isError,
  );
}

void showMessengerSnackBar(
  ScaffoldMessengerState messenger,
  String message, {
  bool isError = false,
}) {
  final colors = Theme.of(messenger.context).colorScheme;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: isError ? colors.errorContainer : null,
        content: Text(
          message,
          style: isError ? TextStyle(color: colors.onErrorContainer) : null,
        ),
      ),
    );
}

void showComingSoon(BuildContext context) {
  showAppSnackBar(
    context,
    'Функцію буде реалізовано в наступних лабораторних роботах',
  );
}
