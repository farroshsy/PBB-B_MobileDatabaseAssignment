import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Sign out use case
class SignOutUseCase implements UseCase<void, NoParams> {
  /// Creates a sign out use case
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _repository.signOut();
  }
}