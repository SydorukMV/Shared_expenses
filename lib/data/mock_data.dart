import 'models/app_user.dart';
import 'models/expense.dart';
import 'models/expense_category.dart';
import 'models/expense_group.dart';

abstract final class MockData {
  static const currentUser = AppUser(
    fullName: 'Марія Сидорук',
    email: 'mariia.sydoruk@example.com',
  );

  static const owedToMe = 900;
  static const iOwe = 350;

  static const groups = [
    ExpenseGroup(
      name: 'Поїздка в Карпати',
      membersCount: 4,
      totalAmount: 6900,
      balance: 900,
      category: ExpenseCategory.trip,
    ),
    ExpenseGroup(
      name: 'Квартира на Сихові',
      membersCount: 3,
      totalAmount: 1050,
      balance: -350,
      category: ExpenseCategory.housing,
    ),
    ExpenseGroup(
      name: 'День народження Ірини',
      membersCount: 5,
      totalAmount: 2500,
      balance: 0,
      category: ExpenseCategory.celebration,
    ),
  ];

  static final expenses = [
    Expense(
      title: 'Кафе «Гуцулка»',
      groupName: 'Поїздка в Карпати',
      date: DateTime(2026, 10, 6),
      amount: 900,
      myShare: 300,
      category: ExpenseCategory.cafe,
    ),
    Expense(
      title: 'Продукти в АТБ',
      groupName: 'Поїздка в Карпати',
      date: DateTime(2026, 10, 5),
      amount: 1200,
      myShare: 400,
      category: ExpenseCategory.groceries,
    ),
    Expense(
      title: 'Оренда будиночка',
      groupName: 'Поїздка в Карпати',
      date: DateTime(2026, 10, 3),
      amount: 3200,
      myShare: 800,
      category: ExpenseCategory.housing,
    ),
    Expense(
      title: 'Квитки на потяг',
      groupName: 'Поїздка в Карпати',
      date: DateTime(2026, 10, 2),
      amount: 1600,
      myShare: 400,
      category: ExpenseCategory.transport,
    ),
    Expense(
      title: 'Комунальні послуги',
      groupName: 'Квартира на Сихові',
      date: DateTime(2026, 10, 1),
      amount: 1050,
      myShare: 350,
      category: ExpenseCategory.utilities,
    ),
  ];
}
