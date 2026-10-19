import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/mock_data.dart';
import '../widgets/photo_options_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    showAppSnackBar(context, 'Зміни збережено');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Редагування профілю')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            Center(
              child: UserAvatar(
                initials: user.initials,
                radius: 48,
                showCameraBadge: true,
                onTap: () => showPhotoOptionsSheet(context),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: TextButton(
                onPressed: () => showPhotoOptionsSheet(context),
                child: const Text('Змінити фото'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Ім\'я та прізвище',
              initialValue: user.fullName,
              keyboardType: TextInputType.name,
              validator: Validators.notEmpty('Введіть ім\'я та прізвище'),
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Email',
              initialValue: user.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              helperText: 'Після зміни email на нову адресу буде надіслано лист для підтвердження',
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: 'Зберегти зміни', onPressed: _save),
          ],
        ),
      ),
    );
  }
}
