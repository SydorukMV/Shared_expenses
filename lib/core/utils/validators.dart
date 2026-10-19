import 'package:flutter/widgets.dart';

abstract final class Validators {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static FormFieldValidator<String> notEmpty(String message) {
    return (value) => (value == null || value.trim().isEmpty) ? message : null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Введіть email';
    if (!_emailPattern.hasMatch(email)) return 'Некоректний формат email';
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasLetter = RegExp(r'[^\d\s]').hasMatch(password);
    if (password.length < 8 || !hasDigit || !hasLetter) {
      return 'Щонайменше 8 символів, літери та цифри';
    }
    return null;
  }

  static FormFieldValidator<String> matches(
    TextEditingController other,
    String message,
  ) {
    return (value) => value == other.text ? null : message;
  }
}
