import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../repositories/splash_repository.dart';

/// Initialize app use case
class InitializeAppUseCase implements UseCase<bool, NoParams> {
  /// Creates an initialize app use case
  const InitializeAppUseCase(this._repository);

  final SplashRepository _repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    // First, initialize services
    final servicesResult = await _repository.initializeServices();
    
    // Return early if service initialization failed
    if (servicesResult.isLeft()) {
      return servicesResult;
    }
    
    // Then, preload assets
    return _repository.preloadAssets();
  }
}