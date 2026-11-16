import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/models/app_user.dart';
import '../../shell/main_shell.dart';
import 'login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  StreamSubscription<AppUser?>? _subscription;
  AppUser? _user;
  bool _isRestoring = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription ??= AppScope.of(context).authRepository
        .authStateChanges()
        .listen(_onAuthStateChanged);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onAuthStateChanged(AppUser? user) {
    if (_isRestoring && user != null) {
      showAppSnackBar(context, 'Сеанс відновлено. Ви увійшли як ${user.email}');
    }
    AppScope.of(context).analytics.logScreen(user == null ? 'login' : 'home');
    setState(() {
      _user = user;
      _isRestoring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _user;
    if (_isRestoring) return const _SessionRestoreView();
    if (user == null) return const LoginScreen();
    return MainShell(key: ValueKey(user.uid));
  }
}

class _SessionRestoreView extends StatelessWidget {
  const _SessionRestoreView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(),
            const SizedBox(height: AppSpacing.lg),
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Відновлення сеансу…',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
