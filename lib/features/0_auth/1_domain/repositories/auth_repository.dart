import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/user.dart';
import '../entities/auth_credentials.dart';

/// Auth repository interface in the domain layer
abstract class AuthRepository {
  /// Get current user
  Future<Either<Failure, User>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<Failure, User>> signIn(AuthCredentials credentials);

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Sign up with email and password
  Future<Either<Failure, User>> signUp(AuthCredentials credentials);

  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  
  /// Get user by ID
  Future<Either<Failure, User>> getAuth(String id);
}