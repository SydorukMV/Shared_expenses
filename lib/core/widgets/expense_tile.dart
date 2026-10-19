import 'package:flutter/material.dart';

import '../../data/models/expense.dart';
import '../utils/formatters.dart';
import 'category_icon.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.expense,
    this.showDate = true,
    this.onTap,
  });

  final Expense expense;
  final bool showDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = showDate
        ? '${expense.groupName} · ${formatShortDate(expense.date)}'
        : expense.groupName;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CategoryIcon(category: expense.category),
      title: Text(expense.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatMoney(expense.amount),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'частка ${formatMoney(expense.myShare)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
