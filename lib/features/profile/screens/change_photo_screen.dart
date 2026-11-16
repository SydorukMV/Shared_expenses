import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/profile_photos.dart';
import '../../../core/di/app_scope.dart';
import '../../../core/utils/snackbars.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/auth_failure.dart';

class ChangePhotoScreen extends StatefulWidget {
  const ChangePhotoScreen({super.key});

  @override
  State<ChangePhotoScreen> createState() => _ChangePhotoScreenState();
}

class _ChangePhotoScreenState extends State<ChangePhotoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  late final AppUser _user = AppScope.of(context).authRepository.currentUser!;
  late String? _selectedUrl = _user.photoUrl;
  String _source = 'preset';
  bool _isCheckingUrl = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _selectPreset(String url) {
    setState(() {
      _selectedUrl = url;
      _source = 'preset';
    });
  }

  Future<void> _previewCustomUrl() async {
    if (_isCheckingUrl || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final url = _urlController.text.trim();

    setState(() => _isCheckingUrl = true);
    var isLoaded = true;
    await precacheImage(
      NetworkImage(url),
      context,
      onError: (_, _) => isLoaded = false,
    );
    if (!mounted) return;
    setState(() {
      _isCheckingUrl = false;
      if (isLoaded) {
        _selectedUrl = url;
        _source = 'url';
      }
    });
    if (!isLoaded) {
      showAppSnackBar(
        context,
        'Не вдалося завантажити зображення за цим посиланням',
        isError: true,
      );
    }
  }

  Future<void> _save() async {
    if (_isSaving) return;
    final scope = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isSaving = true);
    try {
      await scope.profileRepository.updatePhotoUrl(_selectedUrl);
      scope.analytics.logProfilePhotoChanged(_source);
      showMessengerSnackBar(messenger, 'Фото профілю оновлено');
      navigator.pop();
    } on AuthFailure catch (failure) {
      showMessengerSnackBar(messenger, failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChanges = _selectedUrl != null && _selectedUrl != _user.photoUrl;

    return Scaffold(
      appBar: AppBar(title: const Text('Фото профілю')),
      body: Form(
        key: _formKey,
        child: FormPageBody(
          children: [
            Center(
              child: UserAvatar(
                initials: _user.initials,
                photoUrl: _selectedUrl,
                radius: 56,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Готові зображення', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final url in ProfilePhotos.presets)
                  _PresetPhoto(
                    url: url,
                    isSelected: url == _selectedUrl,
                    onTap: () => _selectPreset(url),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Власне посилання', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _urlController,
              label: 'HTTPS-посилання на зображення',
              prefixIcon: Icons.link,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              validator: Validators.httpsUrl,
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: _isCheckingUrl ? null : _previewCustomUrl,
              icon: _isCheckingUrl
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.visibility),
              label: const Text('Попередній перегляд'),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Зберегти фото',
              isLoading: _isSaving,
              onPressed: hasChanges ? _save : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetPhoto extends StatelessWidget {
  const _PresetPhoto({
    required this.url,
    required this.isSelected,
    required this.onTap,
  });

  final String url;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Готове фото профілю',
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? colors.primary : Colors.transparent,
              width: 3,
            ),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: colors.surfaceContainerHighest,
            foregroundImage: NetworkImage(url),
            onForegroundImageError: (_, _) {},
          ),
        ),
      ),
    );
  }
}
