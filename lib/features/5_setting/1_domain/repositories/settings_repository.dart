import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/app_settings.dart';

/// Settings repository interface in the domain layer
abstract class SettingsRepository {
  /// Get application settings
  Future<Either<Failure, AppSettings>> getSettings();

  /// Update application settings
  Future<Either<Failure, AppSettings>> updateSettings(AppSettings settings);
  
  /// Update theme mode
  Future<Either<Failure, ThemeMode>> updateThemeMode(ThemeMode themeMode);
  
  /// Update app locale
  Future<Either<Failure, String>> updateLocale(String locale);
  
  /// Clear application cache
  Future<Either<Failure, bool>> clearCache();
}
