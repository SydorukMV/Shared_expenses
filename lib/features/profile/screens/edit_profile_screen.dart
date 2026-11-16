import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/auth_failure.dart';
import '../../auth/widgets/current_user_builder.dart';
import '../widgets/password_confirm_dialog.dart';
import '../widgets/photo_options_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final AppUser _initialUser = AppScope.of(context)
      .authRepository
      .currentUser!;
  late final _nameController = TextEditingController(
    text: _initialUser.fullName,
  );
  late final _emailController = TextEditingController(text: _initialUser.email);
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final fullName = _nameController.text.trim();
    final email = _emailController.text.trim();
    final emailChanged = email != _initialUser.email;

    setState(() => _isLoading = true);
    try {
      if (fullName != _initialUser.fullName) {
        await scope.profileRepository.updateFullName(fullName);
      }
      if (emailChanged) await _changeEmail(email);
      scope.analytics.logProfileUpdated(emailChanged: emailChanged);
      showMessengerSnackBar(
        messenger,
        emailChanged
            ? 'Зміни збережено. Підтвердіть новий email за посиланням у листі на $email'
            : 'Зміни збережено',
      );
      navigator.pop();
    } on AuthFailure catch (failure) {
      showMessengerSnackBar(messenger, failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _changeEmail(String email) async {
    final profileRepository = AppScope.of(context).profileRepository;
    try {
      await profileRepository.updateEmail(email);
    } on AuthFailure catch (failure) {
      if (!failure.requiresRecentLogin || !mounted) rethrow;
      final password = await showPasswordConfirmDialog(context);
      if (password == null) {
        throw const AuthFailure(
          'Email не змінено: потрібно підтвердити пароль',
        );
      }
      await profileRepository.reauthenticate(password);
      await profileRepository.updateEmail(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редагування профілю')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            CurrentUserBuilder(
              builder: (context, user) => Column(
                children: [
                  UserAvatar(
                    initials: user.initials,
                    photoUrl: user.photoUrl,
                    radius: 48,
                    showCameraBadge: true,
                    onTap: () => showPhotoOptionsSheet(context, user),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => showPhotoOptionsSheet(context, user),
                    child: const Text('Змінити фото'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _nameController,
              label: 'Ім\'я та прізвище',
              keyboardType: TextInputType.name,
              validator: Validators.fullName,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              helperText: 'Після зміни email на нову адресу буде надіслано лист для підтвердження',
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Зберегти зміни',
              isLoading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
