import 'package:dartz/dartz.dart';
import 'package:my_app/features/0_auth/1_domain/entities/auth_credentials.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Parameters for the login use case
class LoginParams {
  /// Creates login parameters
  const LoginParams({
    required this.email,
    required this.password,
  });

  /// Email address
  final String email;

  /// Password
  final String password;
}

/// Login use case in the domain layer
///
/// This use case handles the login operation by delegating to the auth repository.
class LoginUseCase implements UseCase<User, LoginParams> {
  /// Creates a login use case
  const LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    final credentials = AuthCredentials(
      email: params.email,
      password: params.password,
    );

    return _authRepository.signIn(credentials);
  }
}
