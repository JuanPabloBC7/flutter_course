import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Local data source para persistir/recuperar tokens de autenticación.
///
/// Usa [FlutterSecureStorage] que almacena datos de forma encriptada:
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences (AES)
class AuthLocalDataSource {
  static const _keyAccessToken = 'auth_access_token';
  static const _keyRefreshToken = 'auth_refresh_token';

  /// Opciones de Android para usar EncryptedSharedPreferences.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Almacena los tokens de autenticación de forma segura.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
    await _storage.write(key: _keyRefreshToken, value: refreshToken);
  }

  /// Recupera el access token almacenado.
  Future<String?> getAccessToken() async {
    return _storage.read(key: _keyAccessToken);
  }

  /// Recupera el refresh token almacenado.
  Future<String?> getRefreshToken() async {
    return _storage.read(key: _keyRefreshToken);
  }

  /// Elimina todos los tokens almacenados.
  Future<void> clearTokens() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyRefreshToken);
  }

  /// Verifica si existen tokens en el almacenamiento.
  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
