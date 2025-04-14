import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../models/profile_model.dart';

/// Profile remote data source interface
abstract class ProfileRemoteDataSource {
  /// Get all profile items
  Future<List<ProfileModel>> getAll();

  /// Get profile by ID
  Future<ProfileModel> getById(String id);
}

/// Implementation of [ProfileRemoteDataSource] using Dio HTTP client
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  /// Creates a profile remote data source
  const ProfileRemoteDataSourceImpl({
    required this.client,
  });

  /// The HTTP client
  final Dio client;

  @override
  Future<List<ProfileModel>> getAll() async {
    try {
      final response = await client.get<List<dynamic>>('/api/profiles');
      
      return response.data!
        .map((json) => ProfileModel.fromJson(json as Map<String, dynamic>))
        .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get profiles',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProfileModel> getById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/api/profiles/$id');
      
      return ProfileModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get profile',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
