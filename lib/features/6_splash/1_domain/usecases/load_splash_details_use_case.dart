import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
// Import removed as it's not needed for the abstract class signature
// import '../repositories/splash_repository.dart';

/// Abstract use case for loading splash details asynchronously.
abstract class LoadSplashDetailsUseCase implements UseCase<void, NoParams> {
  @override
  Future<Either<Failure, void>> call(NoParams params);
}

// Removed previous concrete class implementation
/*
class LoadSplashDetailsUseCase {
  final SplashRepository _repository;

  /// Creates a new LoadSplashDetailsUseCase
  const LoadSplashDetailsUseCase(this._repository);

  /// Call method to be compatible with the Use Case pattern
  Future<void> call(void _) async {
    return await _repository.loadSplashDetails();
  }
}
*/