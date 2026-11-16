import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../auth/widgets/current_user_builder.dart';
import '../widgets/photo_options_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      icon: Icons.logout,
      title: 'Вийти з облікового запису?',
      message: 'Щоб знову побачити свої групи й витрати, потрібно буде ввести email і пароль.',
      confirmLabel: 'Вийти',
    );
    if (!confirmed || !context.mounted) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await scope.authRepository.signOut();
    scope.analytics.logLogout();
    showMessengerSnackBar(messenger, 'Ви вийшли з облікового запису');
  }

  static void _throwTestError() {
    throw StateError('Тестова помилка для перевірки Firebase Crashlytics');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: CurrentUserBuilder(
        builder: (context, user) => ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Center(
              child: UserAvatar(
                initials: user.initials,
                photoUrl: user.photoUrl,
                radius: 48,
                showCameraBadge: true,
                onTap: () => showPhotoOptionsSheet(context, user),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              user.fullName,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.person,
                  title: 'Редагувати профіль',
                  onTap: () => navigator.pushNamed(AppRoutes.editProfile),
                ),
                SettingsTile(
                  icon: Icons.photo_camera,
                  title: 'Змінити фото',
                  onTap: () => showPhotoOptionsSheet(context, user),
                ),
                SettingsTile(
                  icon: Icons.key,
                  title: 'Змінити пароль',
                  onTap: () => navigator.pushNamed(AppRoutes.changePassword),
                ),
              ],
            ),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.dark_mode,
                  title: 'Тема',
                  subtitle: 'Як у системі',
                  onTap: () => showComingSoon(context),
                ),
                SettingsTile(
                  icon: Icons.language,
                  title: 'Мова',
                  subtitle: 'Українська',
                  onTap: () => showComingSoon(context),
                ),
              ],
            ),
            if (kDebugMode)
              const SettingsGroup(
                children: [
                  SettingsTile(
                    icon: Icons.bug_report,
                    title: 'Тестова помилка Crashlytics',
                    subtitle: 'Доступно лише в debug-збірці',
                    onTap: _throwTestError,
                  ),
                ],
              ),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.logout,
                  title: 'Вийти',
                  isDestructive: true,
                  onTap: () => _confirmLogout(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
