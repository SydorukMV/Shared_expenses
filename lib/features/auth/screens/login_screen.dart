import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      body: FormPageBody(
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
          const AppTextField(
            label: 'Email',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppTextField(
            label: 'Пароль',
            prefixIcon: Icons.lock,
            isPassword: true,
            textInputAction: TextInputAction.done,
            autofillHints: [AutofillHints.password],
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
            onPressed: () => navigator.pushReplacementNamed(AppRoutes.home),
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
    );
  }
}
