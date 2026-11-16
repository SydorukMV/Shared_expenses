import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/repositories/auth_failure.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isLoading = true);
    try {
      await scope.authRepository.signUp(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      scope.analytics.logSignUp();
      showMessengerSnackBar(messenger, 'Обліковий запис створено');
      navigator.popUntil((route) => route.isFirst);
    } on AuthFailure catch (failure) {
      showMessengerSnackBar(
        messenger,
        'Не вдалося зареєструватися. ${failure.message}',
        isError: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
              controller: _nameController,
              label: 'Ім\'я та прізвище',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              validator: Validators.fullName,
            ),
            const SizedBox(height: AppSpacing.md),
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
              isLoading: _isLoading,
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
