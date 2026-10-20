import 'expense_category.dart';

class ExpenseGroup {
  const ExpenseGroup({
    required this.name,
    required this.membersCount,
    required this.totalAmount,
    required this.balance,
    required this.category,
  });

  final String name;
  final int membersCount;
  final int totalAmount;
  final int balance;
  final ExpenseCategory category;
}
