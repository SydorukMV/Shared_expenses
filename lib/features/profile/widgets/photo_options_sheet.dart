import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snackbars.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/auth_failure.dart';

Future<void> showPhotoOptionsSheet(BuildContext context, AppUser user) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      final colors = theme.colorScheme;
      final photoUrl = user.photoUrl;

      void closeAnd(VoidCallback action) {
        Navigator.of(sheetContext).pop();
        action();
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
              title: const Text('Вибрати фото'),
              subtitle: const Text('Готові зображення або HTTPS-посилання'),
              onTap: () => closeAnd(
                () => Navigator.of(context).pushNamed(AppRoutes.changePhoto),
              ),
            ),
            if (photoUrl != null) ...[
              ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('Переглянути фото'),
                onTap: () => closeAnd(() => _showPhoto(context, photoUrl)),
              ),
              ListTile(
                leading: Icon(Icons.delete, color: colors.error),
                title: Text(
                  'Видалити фото',
                  style: TextStyle(color: colors.error),
                ),
                onTap: () => closeAnd(() => _removePhoto(context)),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      );
    },
  );
}

void _showPhoto(BuildContext context, String url) {
  showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Text('Не вдалося завантажити фото'),
        ),
      ),
    ),
  );
}

Future<void> _removePhoto(BuildContext context) async {
  final scope = AppScope.of(context);
  final messenger = ScaffoldMessenger.of(context);
  try {
    await scope.profileRepository.updatePhotoUrl(null);
    scope.analytics.logProfilePhotoChanged('removed');
    showMessengerSnackBar(messenger, 'Фото профілю видалено');
  } on AuthFailure catch (failure) {
    showMessengerSnackBar(messenger, failure.message, isError: true);
  }
}
