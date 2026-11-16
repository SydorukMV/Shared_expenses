import 'package:flutter/widgets.dart';

import '../../features/auth/screens/auth_gate.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/reset_link_sent_screen.dart';
import '../../features/profile/screens/change_password_screen.dart';
import '../../features/profile/screens/change_photo_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';

abstract final class AppRoutes {
  static const root = '/';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const resetLinkSent = '/forgot-password/sent';
  static const editProfile = '/profile/edit';
  static const changePassword = '/profile/password';
  static const changePhoto = '/profile/photo';

  static final Map<String, WidgetBuilder> routes = {
    root: (_) => const AuthGate(),
    register: (_) => const RegisterScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
    resetLinkSent: (_) => const ResetLinkSentScreen(),
    editProfile: (_) => const EditProfileScreen(),
    changePassword: (_) => const ChangePasswordScreen(),
    changePhoto: (_) => const ChangePhotoScreen(),
  };
}
