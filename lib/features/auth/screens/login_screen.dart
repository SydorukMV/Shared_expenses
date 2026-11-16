import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/repositories/auth_failure.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final email = _emailController.text.trim();

    setState(() => _isLoading = true);
    try {
      await scope.authRepository.signIn(
        email: email,
        password: _passwordController.text,
      );
      scope.analytics.logLogin();
      showMessengerSnackBar(messenger, 'Вхід виконано: $email');
    } on AuthFailure catch (failure) {
      showMessengerSnackBar(
        messenger,
        'Не вдалося увійти. ${failure.message}',
        isError: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: FormPageBody(
          centerVertically: true,
          children: [
            const Align(alignment: Alignment.centerLeft, child: AppLogo()),
            const SizedBox(height: AppSpacing.lg),
            Text('Вхід', style: theme.textTheme.headlineLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Shared Expenses — облік витрат групи та частки кожного учасника',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _emailController,
              label: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _passwordController,
              label: 'Пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              validator: Validators.notEmpty('Введіть пароль'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => navigator.pushNamed(AppRoutes.forgotPassword),
                child: const Text('Забули пароль?'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Увійти',
              isLoading: _isLoading,
              onPressed: _signIn,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Немає облікового запису?'),
                TextButton(
                  onPressed: () => navigator.pushNamed(AppRoutes.register),
                  child: const Text('Зареєструватися'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
