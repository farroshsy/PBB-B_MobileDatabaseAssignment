import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

/// Update settings use case parameters
class UpdateSettingsParams {
  /// Creates update settings parameters
  const UpdateSettingsParams({required this.settings});
  
  /// Settings to update
  final AppSettings settings;
}

/// Update application settings use case
class UpdateSettingsUseCase implements UseCase<AppSettings, UpdateSettingsParams> {
  /// Creates an update settings use case
  const UpdateSettingsUseCase(this._settingsRepository);

  final SettingsRepository _settingsRepository;

  @override
  Future<Either<Failure, AppSettings>> call(UpdateSettingsParams params) {
    return _settingsRepository.updateSettings(params.settings);
  }
}
