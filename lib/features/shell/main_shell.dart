import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../expenses/screens/expenses_screen.dart';
import '../groups/screens/groups_screen.dart';
import '../home/screens/home_screen.dart';
import '../profile/screens/profile_screen.dart';

enum MainTab { home, groups, expenses, profile }

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  MainTab _currentTab = MainTab.home;

  void _openTab(MainTab tab) => setState(() => _currentTab = tab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.contentMaxWidth,
          ),
          child: IndexedStack(
            index: _currentTab.index,
            children: [
              HomeScreen(onOpenTab: _openTab),
              const GroupsScreen(),
              const ExpensesScreen(),
              const ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTab.index,
        onDestinationSelected: (index) => _openTab(MainTab.values[index]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Головна',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Групи',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Витрати',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Профіль',
          ),
        ],
      ),
    );
  }
}
