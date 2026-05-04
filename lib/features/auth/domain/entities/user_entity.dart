/// Core user entity representing an authenticated user.
/// This is a pure domain object with no dependencies on external layers.
class UserEntity {
  final int id;
  final String username;
  final String email;
  final String fullName;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username;

  @override
  int get hashCode => id.hashCode ^ username.hashCode;

  @override
  String toString() => 'UserEntity(id: $id, username: $username, email: $email)';
}
