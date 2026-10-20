import 'package:flutter/material.dart';

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showComingSoon(BuildContext context) {
  showAppSnackBar(
    context,
    'Функцію буде реалізовано в наступних лабораторних роботах',
  );
}
