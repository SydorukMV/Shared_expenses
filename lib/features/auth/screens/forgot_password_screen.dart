import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendLink() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.resetLinkSent,
      arguments: _emailController.text.trim(),
    );
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
            PrimaryButton(label: 'Надіслати посилання', onPressed: _sendLink),
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
