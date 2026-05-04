/// Base class for all application exceptions.
/// Every custom exception extends this so we can catch [AppException]
/// at the top level and handle it uniformly.
class AppException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => 'AppException($statusCode): $message';
}

/// Thrown when there is no internet connection or the server is unreachable.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection. Please check your network.',
    super.originalError,
  });
}

/// Thrown when the server returns a 500+ error.
class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error. Please try again later.',
    super.statusCode,
    super.originalError,
  });
}

/// Thrown when the user is not authenticated (401).
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Session expired. Please log in again.',
    super.statusCode = 401,
    super.originalError,
  });
}

/// Thrown when the user does not have permission (403).
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'You do not have permission to perform this action.',
    super.statusCode = 403,
    super.originalError,
  });
}

/// Thrown when the requested resource is not found (404).
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.statusCode = 404,
    super.originalError,
  });
}

/// Thrown when the request times out.
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'The request timed out. Please try again.',
    super.originalError,
  });
}

/// Thrown when the request is invalid (400).
class BadRequestException extends AppException {
  const BadRequestException({
    super.message = 'Invalid request. Please check your data.',
    super.statusCode = 400,
    super.originalError,
  });
}
