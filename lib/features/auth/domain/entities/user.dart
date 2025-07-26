class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String provider;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.provider,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}