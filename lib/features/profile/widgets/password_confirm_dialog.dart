import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';

Future<String?> showPasswordConfirmDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) => const _PasswordConfirmDialog(),
  );
}

class _PasswordConfirmDialog extends StatefulWidget {
  const _PasswordConfirmDialog();

  @override
  State<_PasswordConfirmDialog> createState() => _PasswordConfirmDialogState();
}

class _PasswordConfirmDialogState extends State<_PasswordConfirmDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.lock),
      title: const Text('Підтвердьте пароль'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'З міркувань безпеки введіть поточний пароль, щоб змінити email.',
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _passwordController,
              label: 'Поточний пароль',
              prefixIcon: Icons.lock,
              isPassword: true,
              textInputAction: TextInputAction.done,
              validator: Validators.notEmpty('Введіть поточний пароль'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Скасувати'),
        ),
        TextButton(onPressed: _submit, child: const Text('Підтвердити')),
      ],
    );
  }
}
