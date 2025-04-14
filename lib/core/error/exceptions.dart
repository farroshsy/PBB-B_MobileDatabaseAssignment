/// Exception thrown when server returns an error
class ServerException implements Exception {
  /// Message of the exception
  final String message;

  /// Status code of the exception
  final int? statusCode;

  /// Constructor of the exception
  ServerException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'ServerException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
  }
}

/// Exception thrown when cache operations fail
class CacheException implements Exception {
  /// Message of the exception
  final String message;

  /// Constructor of the exception
  CacheException({required this.message});

  @override
  String toString() {
    return 'CacheException: $message';
  }
}

/// Exception thrown when network is not available
class NetworkException implements Exception {
  /// Message of the exception
  final String message;

  /// Constructor of the exception
  NetworkException({required this.message});

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}

/// Exception thrown when authentication fails
class AuthException implements Exception {
  /// Message of the exception
  final String message;

  /// Constructor of the exception
  AuthException({required this.message});

  @override
  String toString() {
    return 'AuthException: $message';
  }
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  /// Message of the exception
  final String message;

  /// Field causing the exception
  final String? field;

  /// Constructor of the exception
  ValidationException({required this.message, this.field});

  @override
  String toString() {
    return 'ValidationException: $message${field != null ? ' (Field: $field)' : ''}';
  }
}
