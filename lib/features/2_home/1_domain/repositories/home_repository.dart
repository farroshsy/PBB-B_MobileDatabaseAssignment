import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/home.dart';
import '../entities/home_data.dart';

/// Home repository interface in the domain layer
abstract class HomeRepository {
  /// Get all home items
  Future<Either<Failure, List<Home>>> getAll();

  /// Get a specific home by ID
  Future<Either<Failure, Home>> getById(String id);
  
  /// Get home screen data
  Future<Either<Failure, HomeData>> getHomeData();
  
  /// Mark notification as read
  Future<Either<Failure, bool>> markNotificationAsRead(String notificationId);
}
