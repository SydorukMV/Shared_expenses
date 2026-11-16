import 'package:flutter/widgets.dart';

abstract final class Validators {
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static FormFieldValidator<String> notEmpty(String message) {
    return (value) => (value == null || value.trim().isEmpty) ? message : null;
  }

  static String? fullName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Введіть ім\'я та прізвище';
    if (name.length < 2 || name.length > 50) {
      return 'Ім\'я має містити від 2 до 50 символів';
    }
    return null;
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
    final hasLetter = RegExp(r'\p{L}', unicode: true).hasMatch(password);
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

  static FormFieldValidator<String> differs(
    TextEditingController other,
    String message,
  ) {
    return (value) => value == other.text ? message : null;
  }

  static String? httpsUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Вставте посилання на зображення';
    final uri = Uri.tryParse(text);
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      return 'Посилання має починатися з https://';
    }
    return null;
  }
}
