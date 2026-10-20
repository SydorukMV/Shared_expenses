import 'package:flutter/material.dart';

import '../../data/models/expense_group.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'category_icon.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group, this.onTap});

  final ExpenseGroup group;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CategoryIcon(
        category: group.category,
        size: 48,
        circular: false,
      ),
      title: Text(group.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(formatMembers(group.membersCount)),
      trailing: Text(
        formatMoney(group.balance, signed: true),
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.balanceColor(group.balance),
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}
