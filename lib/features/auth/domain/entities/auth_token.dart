/// Represents the authentication tokens returned after a successful login.
class AuthToken {
  final String accessToken;
  final String refreshToken;

  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  String toString() => 'AuthToken(accessToken: ${accessToken.substring(0, 8)}...)';
}
