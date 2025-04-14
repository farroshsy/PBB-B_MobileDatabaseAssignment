import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../repositories/splash_repository.dart';

/// Check if user is authenticated use case
class IsAuthenticatedUseCase implements UseCase<bool, NoParams> {
  /// Creates an is authenticated use case
  const IsAuthenticatedUseCase(this._repository);

  final SplashRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return _repository.isAuthenticated();
  }
}