import 'package:flutter/material.dart';

import '../../../core/di/app_scope.dart';
import '../../../data/models/app_user.dart';
import '../../../data/repositories/auth_repository.dart';

class CurrentUserBuilder extends StatefulWidget {
  const CurrentUserBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, AppUser user) builder;

  @override
  State<CurrentUserBuilder> createState() => _CurrentUserBuilderState();
}

class _CurrentUserBuilderState extends State<CurrentUserBuilder> {
  late final AuthRepository _authRepository = AppScope.of(context)
      .authRepository;
  late final Stream<AppUser?> _userChanges = _authRepository.userChanges();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: _userChanges,
      initialData: _authRepository.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const SizedBox.shrink();
        return widget.builder(context, user);
      },
    );
  }
}
