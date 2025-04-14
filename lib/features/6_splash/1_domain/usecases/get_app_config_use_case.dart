import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/core/config/app_config.dart';
import '../repositories/splash_repository.dart';

/// Get application configuration use case
class GetAppConfigUseCase implements UseCase<AppConfig, NoParams> {
  /// Creates a get app config use case
  const GetAppConfigUseCase(this._repository);

  final SplashRepository _repository;

  @override
  Future<Either<Failure, AppConfig>> call(NoParams params) async {
    return _repository.getAppConfig();
  }
}