import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';

class ResetLinkSentScreen extends StatelessWidget {
  const ResetLinkSentScreen({super.key});

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
            onPressed: () => showAppSnackBar(context, 'Лист надіслано ще раз'),
            child: const Text('Надіслати ще раз'),
          ),
        ],
      ),
    );
  }
}
