class AppUser {
  const AppUser({required this.fullName, required this.email, this.photoUrl});

  final String fullName;
  final String email;
  final String? photoUrl;

  String get initials => fullName
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}
