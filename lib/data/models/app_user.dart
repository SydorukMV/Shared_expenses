class AppUser {
  const AppUser({
    required this.uid,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  final String uid;
  final String fullName;
  final String email;
  final String? photoUrl;

  String get initials {
    final letters = fullName
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    if (letters.isNotEmpty) return letters;
    return email.isEmpty ? '?' : email[0].toUpperCase();
  }
}
