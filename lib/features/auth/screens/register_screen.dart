import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            Text(
              'Створіть обліковий запис, щоб вести спільні витрати з друзями та родиною.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              label: 'Ім\'я та прізвище',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              validator: Validators.notEmpty('Введіть ім\'я та прізвище'),
            ),
            const SizedBox(height: AppSpacing.md),
            const AppTextField(
              label: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: [AutofillHints.email],
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _passwordController,
              label: 'Пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              helperText: 'Щонайменше 8 символів, літери та цифри',
              autofillHints: const [AutofillHints.newPassword],
              validator: Validators.password,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Повторіть пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              textInputAction: TextInputAction.done,
              validator: Validators.matches(
                _passwordController,
                'Паролі не збігаються',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Створити обліковий запис',
              onPressed: _register,
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Вже маєте обліковий запис?'),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Увійти'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
