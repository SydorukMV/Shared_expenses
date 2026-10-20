import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';

class BalanceSummaryCard extends StatelessWidget {
  const BalanceSummaryCard({
    super.key,
    required this.owedToMe,
    required this.iOwe,
  });

  final int owedToMe;
  final int iOwe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final onCard = colors.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Загальний баланс за всіма групами',
            style: theme.textTheme.bodyMedium?.copyWith(color: onCard),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            formatMoney(owedToMe - iOwe, signed: true),
            style: theme.textTheme.displaySmall?.copyWith(color: onCard),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _BalancePart(label: 'Вам винні', amount: owedToMe),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _BalancePart(label: 'Ви винні', amount: iOwe),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalancePart extends StatelessWidget {
  const _BalancePart({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(
            formatMoney(amount),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
