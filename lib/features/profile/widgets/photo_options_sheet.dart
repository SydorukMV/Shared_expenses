import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/snackbars.dart';

Future<void> showPhotoOptionsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      final colors = theme.colorScheme;

      void select() {
        Navigator.of(sheetContext).pop();
        showComingSoon(context);
      }

      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text('Фото профілю', style: theme.textTheme.headlineSmall),
            ),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Вибрати з галереї'),
              onTap: select,
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Зробити фото'),
              onTap: select,
            ),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Переглянути фото'),
              onTap: select,
            ),
            ListTile(
              leading: Icon(Icons.delete, color: colors.error),
              title: Text(
                'Видалити фото',
                style: TextStyle(color: colors.error),
              ),
              onTap: select,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'JPEG або PNG до 5 МБ. Під час першого доступу до камери чи галереї '
                'система запитає дозвіл.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
