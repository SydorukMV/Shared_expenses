import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/repositories/auth_failure.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendLink() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    final scope = AppScope.of(context);
    final email = _emailController.text.trim();

    setState(() => _isLoading = true);
    try {
      await scope.authRepository.sendPasswordResetEmail(email);
      scope.analytics.logPasswordResetRequested();
      if (!mounted) return;
      Navigator.of(context)
          .pushReplacementNamed(AppRoutes.resetLinkSent, arguments: email);
    } on AuthFailure catch (failure) {
      if (mounted) showAppSnackBar(context, failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Відновлення пароля')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            const SizedBox(height: AppSpacing.md),
            const Align(
              alignment: Alignment.centerLeft,
              child: IconCircle(icon: Icons.lock),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Забули пароль?', style: theme.textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Введіть email, вказаний під час реєстрації. Ми надішлемо посилання '
              'для створення нового пароля.',
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
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Надіслати посилання',
              isLoading: _isLoading,
              onPressed: _sendLink,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Повернутися до входу'),
            ),
          ],
        ),
      ),
    );
  }
}
