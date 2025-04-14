import 'package:equatable/equatable.dart';

/// Base failure class
abstract class Failure extends Equatable {
  /// Creates a new failure
  const Failure([this.message = '']);

  /// Message describing the failure
  final String message;

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

/// Server failure
class ServerFailure extends Failure {
  /// Creates a server failure with a message
  const ServerFailure({String message = 'Server error occurred'})
      : super(message);

  /// Creates a server failure with a positional message parameter
  const ServerFailure.withMessage([super.message = 'Server error occurred']);
}

/// Cache failure
class CacheFailure extends Failure {
  /// Creates a cache failure with a message
  const CacheFailure({String message = 'Cache error occurred'})
      : super(message);

  /// Creates a cache failure with a positional message parameter
  const CacheFailure.withMessage([super.message = 'Cache error occurred']);
}

/// Network failure
class NetworkFailure extends Failure {
  /// Creates a network failure with a message
  const NetworkFailure({String message = 'Network error occurred'})
      : super(message);

  /// Creates a network failure with a positional message parameter
  const NetworkFailure.withMessage([super.message = 'Network error occurred']);
}

/// Input validation failure
class ValidationFailure extends Failure {
  /// Creates a validation failure with a message
  const ValidationFailure({String message = 'Invalid input'}) : super(message);

  /// Creates a validation failure with a positional message parameter
  const ValidationFailure.withMessage([super.message = 'Invalid input']);
}

/// Not found failure
class NotFoundFailure extends Failure {
  /// Creates a not found failure with a message
  const NotFoundFailure({String message = 'Data not found'}) : super(message);

  /// Creates a not found failure with a positional message parameter
  const NotFoundFailure.withMessage([super.message = 'Data not found']);
}

/// Authentication failure
class AuthFailure extends Failure {
  /// Creates an auth failure with a message
  const AuthFailure({String message = 'Authentication error occurred'})
      : super(message);

  /// Creates an auth failure with a positional message parameter
  const AuthFailure.withMessage(
      [super.message = 'Authentication error occurred']);
}

/// Unknown failure
class UnknownFailure extends Failure {
  /// Creates an unknown failure with a message
  const UnknownFailure({String message = 'Unknown error occurred'})
      : super(message);

  /// Creates an unknown failure with a positional message parameter
  const UnknownFailure.withMessage([super.message = 'Unknown error occurred']);
}
