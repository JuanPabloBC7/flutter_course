import 'package:flutter_course/core/network/api_client.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';

// ignore_for_file: unused_field
// The _client field is declared for future use with real API endpoints.

/// Remote data source for authentication API calls.
///
/// This class handles the raw HTTP communication with the backend.
/// It returns raw Maps that the repository will convert to domain entities.
class AuthRemoteDataSource {
  final ApiClient _client = ApiClient();

  /// Calls the login endpoint.
  /// Returns raw response data on success.
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    // TODO: Replace with real API call when endpoint is available:
    // final response = await _client.post('/auth/login', data: {
    //   'username': username,
    //   'password': password,
    // });
    // return response.data as Map<String, dynamic>;

    await Future.delayed(const Duration(milliseconds: 800));

    // Mock: only accept specific credentials
    if (username != 'jpbalan' || password != '123456') {
      throw const UnauthorizedException(
        message: 'Invalid username or password.',
      );
    }

    return {
      'token': 'mock-jwt-token-abc123',
      'refreshToken': 'mock-refresh-token-xyz789',
      'user': {
        'id': 1,
        'username': 'jpbalan',
        'email': 'jpbalan@example.com',
        'fullName': 'Juan P. Balan',
      },
    };
  }

  /// Calls the logout endpoint.
  Future<void> logout() async {
    // TODO: Replace with real API call:
    // await _client.post('/auth/logout');

    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Calls the password reset endpoint.
  Future<void> requestPasswordReset({
    required String username,
    required String email,
  }) async {
    // TODO: Replace with real API call:
    // await _client.post('/auth/reset-password', data: {
    //   'username': username,
    //   'email': email,
    // });

    await Future.delayed(const Duration(milliseconds: 600));

    if (username.isEmpty || email.isEmpty) {
      throw const BadRequestException(
        message: 'Username and email are required.',
      );
    }
  }
}
