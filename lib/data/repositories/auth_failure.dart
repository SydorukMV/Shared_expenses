import 'package:firebase_auth/firebase_auth.dart';

class AuthFailure implements Exception {
  const AuthFailure(this.message, {this.code});

  factory AuthFailure.fromFirebase(
    FirebaseAuthException error, {
    Map<String, String> messages = const {},
  }) {
    final message =
        messages[error.code] ?? _messages[error.code] ?? _defaultMessage;
    return AuthFailure(message, code: error.code);
  }

  final String message;
  final String? code;

  bool get requiresRecentLogin => code == 'requires-recent-login';

  static const _defaultMessage =
      'Не вдалося виконати операцію. Спробуйте ще раз пізніше';

  static const _messages = {
    'invalid-email': 'Некоректний формат email',
    'invalid-credential': 'Неправильний email або пароль',
    'wrong-password': 'Неправильний email або пароль',
    'user-not-found': 'Неправильний email або пароль',
    'user-disabled': 'Обліковий запис заблоковано',
    'email-already-in-use': 'Цей email уже зареєстровано',
    'weak-password': 'Пароль занадто простий',
    'requires-recent-login':
        'З міркувань безпеки потрібно повторно підтвердити вхід',
    'too-many-requests': 'Забагато спроб. Спробуйте пізніше',
    'network-request-failed': 'Немає з\'єднання з інтернетом',
    'operation-not-allowed': 'Цей спосіб входу вимкнено',
  };

  @override
  String toString() => message;
}
