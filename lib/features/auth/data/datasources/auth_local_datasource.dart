/// Local data source for storing/retrieving auth tokens.
///
/// In a production app, this would use flutter_secure_storage or similar.
/// For now, it uses in-memory storage as a placeholder.
class AuthLocalDataSource {
  // In-memory token storage (replace with secure storage in production)
  String? _accessToken;
  String? _refreshToken;

  /// Stores the authentication tokens locally.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    // TODO: Replace with secure storage:
    // await _secureStorage.write(key: 'access_token', value: accessToken);
    // await _secureStorage.write(key: 'refresh_token', value: refreshToken);

    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  /// Retrieves the stored access token.
  Future<String?> getAccessToken() async {
    // TODO: Replace with secure storage:
    // return await _secureStorage.read(key: 'access_token');

    return _accessToken;
  }

  /// Retrieves the stored refresh token.
  Future<String?> getRefreshToken() async {
    // TODO: Replace with secure storage:
    // return await _secureStorage.read(key: 'refresh_token');

    return _refreshToken;
  }

  /// Clears all stored tokens.
  Future<void> clearTokens() async {
    // TODO: Replace with secure storage:
    // await _secureStorage.deleteAll();

    _accessToken = null;
    _refreshToken = null;
  }

  /// Checks if tokens exist in storage.
  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
