import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/repositories/auth_failure.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _passwordsMatch =>
      _confirmController.text.isNotEmpty &&
      _confirmController.text == _newPasswordController.text;

  String? _validateNewPassword(String? value) {
    return Validators.password(value) ??
        Validators.differs(
          _currentPasswordController,
          'Новий пароль має відрізнятися від поточного',
        )(value);
  }

  Future<void> _changePassword() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isLoading = true);
    try {
      await scope.profileRepository.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      scope.analytics.logPasswordChanged();
      showMessengerSnackBar(messenger, 'Пароль змінено');
      navigator.pop();
    } on AuthFailure catch (failure) {
      final message = failure.requiresRecentLogin
          ? 'Сеанс застарів. Вийдіть і увійдіть повторно, щоб змінити пароль'
          : 'Не вдалося змінити пароль. ${failure.message}';
      showMessengerSnackBar(messenger, message, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
              controller: _currentPasswordController,
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
              validator: _validateNewPassword,
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
            PrimaryButton(
              label: 'Змінити пароль',
              isLoading: _isLoading,
              onPressed: _changePassword,
            ),
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
