import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _passwordsMatch =>
      _confirmController.text.isNotEmpty &&
      _confirmController.text == _newPasswordController.text;

  void _changePassword() {
    if (!_formKey.currentState!.validate()) return;
    showAppSnackBar(context, 'Пароль змінено');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Зміна пароля')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            Text(
              'Новий пароль має містити щонайменше 8 символів, літери та цифри.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              label: 'Поточний пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              autofillHints: const [AutofillHints.password],
              validator: Validators.notEmpty('Введіть поточний пароль'),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _newPasswordController,
              label: 'Новий пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              autofillHints: const [AutofillHints.newPassword],
              validator: Validators.password,
              onChanged: (_) => setState(() {}),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: PasswordStrengthIndicator(
                password: _newPasswordController.text,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _confirmController,
              label: 'Повторіть новий пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              textInputAction: TextInputAction.done,
              suffixIcon: _passwordsMatch
                  ? Icon(Icons.check_circle, color: theme.colorScheme.positive)
                  : null,
              validator: Validators.matches(
                _newPasswordController,
                'Паролі не збігаються',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: 'Змінити пароль', onPressed: _changePassword),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
              child: const Text('Забули поточний пароль?'),
            ),
          ],
        ),
      ),
    );
  }
}
