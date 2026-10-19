import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/mock_data.dart';
import '../../shell/main_shell.dart';
import '../widgets/balance_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenTab});

  final ValueChanged<MainTab> onOpenTab;
  static const _recentExpensesCount = 3;

  @override
  Widget build(BuildContext context) {
    const user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: UserAvatar(
              initials: user.initials,
              onTap: () => onOpenTab(MainTab.profile),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => showComingSoon(context),
        icon: const Icon(Icons.add),
        label: const Text('Нова група'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          96,
        ),
        children: [
          const BalanceSummaryCard(
            owedToMe: MockData.owedToMe,
            iOwe: MockData.iOwe,
          ),
          const SizedBox(height: AppSpacing.md),
          SectionHeader(
            title: 'Мої групи',
            actionLabel: 'Усі',
            onAction: () => onOpenTab(MainTab.groups),
          ),
          for (final group in MockData.groups)
            GroupTile(group: group, onTap: () => showComingSoon(context)),
          const SizedBox(height: AppSpacing.sm),
          SectionHeader(
            title: 'Останні витрати',
            actionLabel: 'Усі',
            onAction: () => onOpenTab(MainTab.expenses),
          ),
          for (final expense in MockData.expenses.take(_recentExpensesCount))
            ExpenseTile(expense: expense, onTap: () => showComingSoon(context)),
        ],
      ),
    );
  }
}
