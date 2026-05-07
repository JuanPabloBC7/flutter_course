import 'package:dio/dio.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';

/// Remote data source for authentication API calls.
///
/// Uses the dummyJSON API for login: https://dummyjson.com/docs/auth
/// Other endpoints (logout, reset) remain as mock for now.
class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://dummyjson.com',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
          },
        ));

  /// Calls the dummyJSON login endpoint.
  ///
  /// API: POST https://dummyjson.com/auth/login
  /// Body: { "username": "emilys", "password": "emilyspass", "expiresInMins": 30 }
  ///
  /// Test credentials: username: "emilys", password: "emilyspass"
  ///
  /// Returns the full response map on success.
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        final message = e.response?.data?['message'] as String? ?? 'Invalid credentials';
        throw UnauthorizedException(message: message);
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutException();
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }
      throw AppException(
        message: e.message ?? 'Login failed',
        originalError: e,
      );
    }
  }

  /// Calls the logout endpoint (mock for now).
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Gets the current authenticated user's profile.
  ///
  /// API: GET https://dummyjson.com/auth/me
  /// Requires Authorization header with Bearer token.
  ///
  /// Used to validate the session on app startup.
  Future<Map<String, dynamic>> getCurrentUser({required String token}) async {
    try {
      final response = await _dio.get(
        '/auth/me',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException(message: 'Session expired. Please log in again.');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutException();
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }
      throw AppException(
        message: e.message ?? 'Failed to get user profile',
        originalError: e,
      );
    }
  }

  /// Refreshes the authentication token.
  ///
  /// API: POST https://dummyjson.com/auth/refresh
  /// Body: `{ "refreshToken": "...", "expiresInMins": 30 }`
  ///
  /// Returns new tokens on success.
  Future<Map<String, dynamic>> refreshToken({required String refreshToken}) async {
    try {
      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'refreshToken': refreshToken,
          'expiresInMins': 30,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        throw const UnauthorizedException(message: 'Refresh token expired. Please log in again.');
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutException();
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }
      throw AppException(
        message: e.message ?? 'Failed to refresh token',
        originalError: e,
      );
    }
  }

  /// Calls the password reset endpoint (mock for now).
  Future<void> requestPasswordReset({
    required String username,
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (username.isEmpty || email.isEmpty) {
      throw const BadRequestException(
        message: 'Username and email are required.',
      );
    }
  }
}
