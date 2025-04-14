import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/setting.dart';

/// Setting repository interface in the domain layer
abstract class SettingRepository {
  /// Get all setting items
  Future<Either<Failure, List<Setting>>> getAll();

  /// Get a specific setting by ID
  Future<Either<Failure, Setting>> getById(String id);
}
