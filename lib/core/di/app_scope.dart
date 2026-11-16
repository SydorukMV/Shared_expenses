import 'package:flutter/widgets.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../services/analytics_service.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.authRepository,
    required this.profileRepository,
    required this.analytics,
    required super.child,
  });

  final AuthRepository authRepository;
  final ProfileRepository profileRepository;
  final AnalyticsService analytics;

  static AppScope of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope is missing in the widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
