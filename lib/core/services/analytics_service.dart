import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService({FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  late final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: _analytics,
  );

  Future<void> logScreen(String screenName) {
    return _analytics.logScreenView(screenName: screenName);
  }

  Future<void> logLogin() => _analytics.logLogin(loginMethod: 'password');

  Future<void> logSignUp() => _analytics.logSignUp(signUpMethod: 'password');

  Future<void> logLogout() => _analytics.logEvent(name: 'logout');

  Future<void> logPasswordResetRequested() {
    return _analytics.logEvent(name: 'password_reset_requested');
  }

  Future<void> logPasswordChanged() {
    return _analytics.logEvent(name: 'password_changed');
  }

  Future<void> logProfileUpdated({required bool emailChanged}) {
    return _analytics.logEvent(
      name: 'profile_updated',
      parameters: {'email_changed': emailChanged ? 'yes' : 'no'},
    );
  }

  Future<void> logProfilePhotoChanged(String source) {
    return _analytics.logEvent(
      name: 'profile_photo_changed',
      parameters: {'source': source},
    );
  }
}
