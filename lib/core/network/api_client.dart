import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';

/// Reusable HTTP client built on top of Dio.
///
/// Features:
/// - Base URL configuration
/// - Auth token interceptor (adds Authorization header)
/// - Logging interceptor (debug mode only)
/// - Centralized error mapping (DioException → AppException)
class ApiClient {
  late final Dio _dio;

  // Singleton pattern so the whole app shares one client instance.
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        // TODO: Replace with your real base URL when available
        baseUrl: 'https://api.example.com/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ── Auth Interceptor ──
    // Adds the Bearer token to every request if available.
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Replace with real token from secure storage
          const token = 'mock-jwt-token-abc123';
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );

    // ── Logging Interceptor ──
    // Only active in debug mode to avoid leaking data in production.
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }
  }

  /// Expose the Dio instance for advanced use cases.
  Dio get dio => _dio;

  // ── HTTP Methods ──────────────────────────────────────────────────────────

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put<T>(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete<T>(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  // ── Error Mapping ─────────────────────────────────────────────────────────

  /// Maps Dio errors to our centralized [AppException] hierarchy.
  AppException _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(originalError: error);

      case DioExceptionType.connectionError:
        return NetworkException(originalError: error);

      case DioExceptionType.badResponse:
        return _mapStatusCode(
          error.response?.statusCode,
          error.response?.data,
          error,
        );

      case DioExceptionType.cancel:
        return const AppException(message: 'Request was cancelled.');

      default:
        return AppException(
          message: error.message ?? 'An unexpected error occurred.',
          originalError: error,
        );
    }
  }

  /// Maps HTTP status codes to specific exception types.
  AppException _mapStatusCode(int? statusCode, dynamic data, DioException error) {
    final serverMessage = data is Map ? data['message'] as String? : null;

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: serverMessage ?? 'Invalid request.',
          originalError: error,
        );
      case 401:
        return UnauthorizedException(
          message: serverMessage ?? 'Session expired. Please log in again.',
          originalError: error,
        );
      case 403:
        return ForbiddenException(
          message: serverMessage ?? 'Access denied.',
          originalError: error,
        );
      case 404:
        return NotFoundException(
          message: serverMessage ?? 'Resource not found.',
          originalError: error,
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: serverMessage ?? 'Server error. Please try again later.',
            statusCode: statusCode,
            originalError: error,
          );
        }
        return AppException(
          message: serverMessage ?? 'Unexpected error (HTTP $statusCode).',
          statusCode: statusCode,
          originalError: error,
        );
    }
  }
}
