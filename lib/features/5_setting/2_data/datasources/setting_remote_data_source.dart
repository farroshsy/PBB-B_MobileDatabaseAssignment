import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../models/setting_model.dart';

/// Setting remote data source interface
abstract class SettingRemoteDataSource {
  /// Get all setting items
  Future<List<SettingModel>> getAll();

  /// Get setting by ID
  Future<SettingModel> getById(String id);
}

/// Implementation of [SettingRemoteDataSource] using Dio HTTP client
class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  /// Creates a setting remote data source
  const SettingRemoteDataSourceImpl({
    required this.client,
  });

  /// The HTTP client
  final Dio client;

  @override
  Future<List<SettingModel>> getAll() async {
    try {
      final response = await client.get<List<dynamic>>('/api/settings');
      
      return response.data!
        .map((json) => SettingModel.fromJson(json as Map<String, dynamic>))
        .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get settings',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<SettingModel> getById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/api/settings/$id');
      
      return SettingModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get setting',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
