import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../../1_domain/entities/auth_credentials.dart';
import '../models/user_model.dart';

/// Authentication remote data source interface
abstract class AuthRemoteDataSource {
  /// Get the current authenticated user
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> getCurrentUser();

  /// Sign in with email and password
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> signInWithEmailAndPassword(AuthCredentials credentials);

  /// Sign up with email and password
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> signUpWithEmailAndPassword(AuthCredentials credentials);

  /// Sign out the current user
  ///
  /// Throws a [ServerException] for all error codes
  Future<void> signOut();

  /// Reset password for the given email
  ///
  /// Throws a [ServerException] for all error codes
  Future<void> resetPassword(String email);

  /// Check if user is signed in
  Future<bool> isSignedIn();

  /// Get authentication data by ID
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> getAuth(String id);
}

/// Implementation of [AuthRemoteDataSource] using Dio HTTP client
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Creates an auth remote data source
  const AuthRemoteDataSourceImpl({
    required this.client,
  });

  /// The HTTP client
  final Dio client;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await client.get<Map<String, dynamic>>('/auth/user');
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get current user',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      AuthCredentials credentials) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '/auth/login',
        data: {
          'email': credentials.email,
          'password': credentials.password,
        },
      );
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Sign in failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      AuthCredentials credentials) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        '/auth/register',
        data: {
          'email': credentials.email,
          'password': credentials.password,
          'name': credentials.email.split('@').first, // Default name from email
        },
      );
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Sign up failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.post<void>('/auth/logout');
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Sign out failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await client.post<void>(
        '/auth/reset-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Reset password failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final response = await client.get<Map<String, dynamic>>('/auth/status');
      return response.data?['authenticated'] == true;
    } on DioException {
      return false;
    }
  }

  @override
  Future<UserModel> getAuth(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/auth/$id');
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get auth by ID',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
