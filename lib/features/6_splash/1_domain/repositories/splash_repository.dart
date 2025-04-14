import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/config/app_config.dart';

/// Splash repository interface in the domain layer
abstract class SplashRepository {
  /// Get application configuration
  Future<Either<Failure, AppConfig>> getAppConfig();

  /// Check if user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();
  
  /// Initialize app services
  Future<Either<Failure, bool>> initializeServices();
  
  /// Get application assets
  Future<Either<Failure, bool>> preloadAssets();
  
  /// Load splash details
  Future<void> loadSplashDetails();
}
