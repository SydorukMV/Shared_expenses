import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/mock_data.dart';
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    const user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(
            child: UserAvatar(
              initials: user.initials,
              radius: 48,
              showCameraBadge: true,
              onTap: () => showPhotoOptionsSheet(context),
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
                onTap: () => showPhotoOptionsSheet(context),
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
    );
  }
}
