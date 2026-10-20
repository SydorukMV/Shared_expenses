import 'expense_category.dart';

class Expense {
  const Expense({
    required this.title,
    required this.groupName,
    required this.date,
    required this.amount,
    required this.myShare,
    required this.category,
  });

  final String title;
  final String groupName;
  final DateTime date;
  final int amount;
  final int myShare;
  final ExpenseCategory category;
}
