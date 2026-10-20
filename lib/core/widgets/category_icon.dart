import 'package:flutter/material.dart';

import '../../data/models/expense_category.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.category,
    this.size = 40,
    this.circular = true,
  });

  final ExpenseCategory category;
  final double size;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? category.onContainer : category.container;
    final foreground = isDark ? category.container : category.onContainer;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circular ? null : BorderRadius.circular(size * 0.3),
      ),
      child: Icon(category.icon, size: size * 0.5, color: foreground),
    );
  }
}
