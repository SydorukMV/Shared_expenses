import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/repositories/auth_failure.dart';

class ResetLinkSentScreen extends StatefulWidget {
  const ResetLinkSentScreen({super.key});

  @override
  State<ResetLinkSentScreen> createState() => _ResetLinkSentScreenState();
}

class _ResetLinkSentScreenState extends State<ResetLinkSentScreen> {
  bool _isSending = false;

  Future<void> _resend(String email) async {
    if (_isSending) return;
    setState(() => _isSending = true);
    try {
      await AppScope.of(context).authRepository.sendPasswordResetEmail(email);
      if (mounted) showAppSnackBar(context, 'Лист надіслано ще раз');
    } on AuthFailure catch (failure) {
      if (mounted) showAppSnackBar(context, failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Закрити',
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FormPageBody(
        centerVertically: true,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconCircle(
            icon: Icons.mark_email_read,
            size: 96,
            backgroundColor: colors.primaryContainer,
            iconColor: colors.onPrimaryContainer,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Перевірте пошту', style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Ми надіслали посилання для відновлення пароля на адресу',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            email,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Посилання дійсне протягом 1 години. Якщо листа немає, перевірте папку «Спам».',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Повернутися до входу',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: _isSending ? null : () => _resend(email),
            child: Text(_isSending ? 'Надсилання…' : 'Надіслати ще раз'),
          ),
        ],
      ),
    );
  }
}
