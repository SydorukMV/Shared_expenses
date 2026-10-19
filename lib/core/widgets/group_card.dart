import 'package:flutter/material.dart';

import '../../data/models/expense_group.dart';
import '../constants/app_spacing.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import 'category_icon.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group, this.onTap});

  final ExpenseGroup group;
  final VoidCallback? onTap;

  String get _status {
    if (group.balance > 0) return 'Вам винні ${formatMoney(group.balance)}';
    if (group.balance < 0) return 'Ви винні ${formatMoney(-group.balance)}';
    return 'Усі розрахунки завершено';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card.outlined(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CategoryIcon(category: group.category, size: 48, circular: false),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name, style: theme.textTheme.titleMedium),
                    Text(
                      '${formatMembers(group.membersCount)} · ${formatMoney(group.totalAmount)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      _status,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.balanceColor(group.balance),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
