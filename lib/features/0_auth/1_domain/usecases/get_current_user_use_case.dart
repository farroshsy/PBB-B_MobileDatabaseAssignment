import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Get current user use case
class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  /// Creates a get current user use case
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return _repository.getCurrentUser();
  }
}