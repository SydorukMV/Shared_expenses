import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/mock_data.dart';
import '../../../data/models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  String _query = '';

  List<Expense> get _visibleExpenses {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return MockData.expenses;
    return MockData.expenses
        .where((expense) => expense.title.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expenses = _visibleExpenses;
    final total = expenses.fold(0, (sum, expense) => sum + expense.amount);
    final myTotal = expenses.fold(0, (sum, expense) => sum + expense.myShare);
    final found = pluralize(expenses.length, 'витрату', 'витрати', 'витрат');

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            SearchBar(
              hintText: 'Пошук витрат за назвою',
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(
                  tooltip: 'Фільтри',
                  icon: const Icon(Icons.tune),
                  onPressed: () => showComingSoon(context),
                ),
              ],
              elevation: const WidgetStatePropertyAll(0),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Знайдено ${expenses.length} $found · ${formatMoney(total)} · '
              'моя частка ${formatMoney(myTotal)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            for (final (index, expense) in expenses.indexed) ...[
              if (index == 0 ||
                  !_isSameDay(expenses[index - 1].date, expense.date))
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(
                    formatDayMonth(expense.date),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ExpenseTile(
                expense: expense,
                showDate: false,
                onTap: () => showComingSoon(context),
              ),
            ],
            if (expenses.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: AppSpacing.xl),
                child: Center(child: Text('Нічого не знайдено')),
              ),
          ],
        ),
      ),
    );
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
