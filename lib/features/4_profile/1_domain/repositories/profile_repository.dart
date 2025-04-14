import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/profile.dart';

/// Profile repository interface in the domain layer
abstract class ProfileRepository {
  /// Get user profile
  Future<Either<Failure, Profile>> getProfile();

  /// Update user profile
  Future<Either<Failure, Profile>> updateProfile(Profile profile);
  
  /// Update user profile photo
  Future<Either<Failure, String>> updateProfilePhoto(String filePath);
  
  /// Update user preferences
  Future<Either<Failure, Map<String, dynamic>>> updatePreferences(Map<String, dynamic> preferences);
}
