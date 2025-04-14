import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

/// Send password reset email use case
class SendPasswordResetEmailUseCase implements UseCase<void, String> {
  /// Creates a send password reset email use case
  const SendPasswordResetEmailUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(String params) async {
    return _repository.sendPasswordResetEmail(params);
  }
}