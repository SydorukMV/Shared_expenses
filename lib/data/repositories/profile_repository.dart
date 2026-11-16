import 'package:firebase_auth/firebase_auth.dart';

import 'auth_failure.dart';

class ProfileRepository {
  ProfileRepository({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  User get _user {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthFailure('Сеанс завершено. Увійдіть повторно');
    }
    return user;
  }

  Future<void> updateFullName(String fullName) {
    return _run(() => _user.updateDisplayName(fullName));
  }

  Future<void> updatePhotoUrl(String? photoUrl) {
    return _run(() => _user.updatePhotoURL(photoUrl));
  }

  Future<void> updateEmail(String newEmail) {
    return _run(() async {
      await _auth.setLanguageCode('uk');
      await _user.verifyBeforeUpdateEmail(newEmail);
    });
  }

  Future<void> reauthenticate(String password) async {
    final user = _user;
    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email!, password: password),
      );
    } on FirebaseAuthException catch (error) {
      throw AuthFailure.fromFirebase(
        error,
        messages: const {
          'invalid-credential': 'Поточний пароль неправильний',
          'wrong-password': 'Поточний пароль неправильний',
        },
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await reauthenticate(currentPassword);
    await _run(() => _user.updatePassword(newPassword));
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseAuthException catch (error) {
      throw AuthFailure.fromFirebase(error);
    }
  }
}
