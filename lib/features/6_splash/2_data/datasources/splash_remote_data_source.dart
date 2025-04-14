import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../models/splash_model.dart';

/// Splash remote data source interface
abstract class SplashRemoteDataSource {
  /// Get all splash items
  Future<List<SplashModel>> getAll();

  /// Get splash by ID
  Future<SplashModel> getById(String id);
}

/// Implementation of [SplashRemoteDataSource] using Dio HTTP client
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  /// Creates a splash remote data source
  const SplashRemoteDataSourceImpl({
    required this.client,
  });

  /// The HTTP client
  final Dio client;

  @override
  Future<List<SplashModel>> getAll() async {
    try {
      final response = await client.get<List<dynamic>>('/api/splashs');
      
      return response.data!
        .map((json) => SplashModel.fromJson(json as Map<String, dynamic>))
        .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get splashs',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<SplashModel> getById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/api/splashs/$id');
      
      return SplashModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get splash',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
