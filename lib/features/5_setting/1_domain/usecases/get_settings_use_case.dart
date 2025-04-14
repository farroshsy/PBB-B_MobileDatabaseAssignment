import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

/// Get application settings use case
class GetSettingsUseCase implements UseCase<AppSettings, NoParams> {
  /// Creates a get settings use case
  const GetSettingsUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<Either<Failure, AppSettings>> call(NoParams params) {
    return _settingsRepository.getSettings();
  }
}
