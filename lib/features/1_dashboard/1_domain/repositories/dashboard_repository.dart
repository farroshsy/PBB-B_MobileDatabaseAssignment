import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/dashboard.dart';
import '../entities/dashboard_stats.dart';

/// Dashboard repository interface in the domain layer
abstract class DashboardRepository {
  /// Get all dashboard items
  Future<Either<Failure, List<Dashboard>>> getAll();

  /// Get a specific dashboard by ID
  Future<Either<Failure, Dashboard>> getById(String id);
  
  /// Get dashboard statistics and metrics
  Future<Either<Failure, DashboardStats>> getDashboardStats();
  
  /// Update dashboard layout
  Future<Either<Failure, Dashboard>> updateLayout(Dashboard dashboard);
}
