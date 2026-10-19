import 'package:flutter/material.dart';

enum ExpenseCategory {
  groceries(
    'Продукти',
    Icons.shopping_cart,
    Color(0xFFFFDDB8),
    Color(0xFF5C3A00),
  ),
  cafe(
    'Кафе й ресторани',
    Icons.restaurant,
    Color(0xFFFFD9E2),
    Color(0xFF5D1133),
  ),
  housing('Житло', Icons.home, Color(0xFFD6E3FF), Color(0xFF0A305F)),
  transport('Транспорт', Icons.train, Color(0xFFC9E7FF), Color(0xFF00344F)),
  utilities(
    'Комунальні послуги',
    Icons.bolt,
    Color(0xFFEFE29C),
    Color(0xFF363000),
  ),
  trip('Подорожі', Icons.landscape, Color(0xFFB9F0D0), Color(0xFF00391C)),
  celebration(
    'Свята й подарунки',
    Icons.cake,
    Color(0xFFFFD9E2),
    Color(0xFF5D1133),
  );

  const ExpenseCategory(
    this.label,
    this.icon,
    this.container,
    this.onContainer,
  );

  final String label;
  final IconData icon;
  final Color container;
  final Color onContainer;
}
