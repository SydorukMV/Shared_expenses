import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart';
import 'auth_failure.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  Stream<AppUser?> authStateChanges() =>
      _auth.authStateChanges().map(_toAppUser);

  Stream<AppUser?> userChanges() => _auth.userChanges().map(_toAppUser);

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(fullName);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure.fromFirebase(error);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure.fromFirebase(error);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.setLanguageCode('uk');
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure.fromFirebase(
        error,
        messages: const {
          'user-not-found': 'Користувача з таким email не знайдено',
        },
      );
    }
  }

  Future<void> signOut() => _auth.signOut();

  static AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      fullName: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL,
    );
  }
}
