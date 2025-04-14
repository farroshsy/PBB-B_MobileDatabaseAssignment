import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/user.dart';
import '../entities/auth_credentials.dart';
import '../repositories/auth_repository.dart';

/// Sign in use case
class SignInUseCase implements UseCase<User, AuthCredentials> {
  /// Creates a sign in use case
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(AuthCredentials params) async {
    return _repository.signIn(params);
  }
}