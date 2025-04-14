import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/network/dio_client.dart';
import 'package:my_app/core/storage/storage_service.dart';
import '../../1_domain/entities/user.dart';
import '../../1_domain/entities/auth_credentials.dart';
import '../../1_domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

/// Implementation of the auth repository
class AuthRepositoryImpl implements AuthRepository {
  /// Creates a new auth repository implementation
  AuthRepositoryImpl({
    required NetworkInfo networkInfo,
    required StorageService localStorage,
    required DioClient remote,
  })  : _networkInfo = networkInfo,
        _localStorage = localStorage,
        _remote = remote;

  final NetworkInfo _networkInfo;
  final StorageService _localStorage;
  final DioClient _remote;

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }

      // Get current user from API
      return Right(const UserModel(
        id: '1',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: null,
        lastSignInAt: null,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(AuthCredentials credentials) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }

      // Sign in with API
      return Right(UserModel(
        id: '1',
        email: credentials.email,
        displayName: credentials.displayName,
        createdAt: DateTime.now(),
        lastSignInAt: DateTime.now(),
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      // Clear stored tokens
      await _localStorage.remove('auth_token');
      // Sign out with API
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(AuthCredentials credentials) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }

      // Sign up with API
      return Right(UserModel(
        id: '1',
        email: credentials.email,
        displayName: credentials.displayName,
        createdAt: DateTime.now(),
        lastSignInAt: null,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }

      // Send password reset email with API
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, User>> getAuth(String id) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }

      // Get user by ID from API
      return Right(const UserModel(
        id: '1',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: null,
        lastSignInAt: null,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
