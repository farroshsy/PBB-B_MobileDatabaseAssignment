import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../models/home_model.dart';
import '../models/home_data_model.dart';

/// Remote data source for home
abstract class HomeRemoteDataSource {
  /// Get all homes
  Future<List<HomeModel>> getHomes();
  
  /// Get home by ID
  Future<HomeModel> getHomeById(String id);
  
  /// Get home data
  Future<HomeDataModel> getHomeData();
  
  /// Mark notification as read
  Future<bool> markNotificationAsRead(String notificationId);
}

/// Implementation of home remote data source
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  /// Creates home remote data source implementation
  const HomeRemoteDataSourceImpl({required this.client});
  
  /// HTTP client
  final Dio client;
  
  @override
  Future<List<HomeModel>> getHomes() async {
    try {
      final response = await client.get<List<dynamic>>('/homes');
      return response.data!
          .map((json) => HomeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch homes',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<HomeModel> getHomeById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/homes/$id');
      return HomeModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch home',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      final response = await client.get<Map<String, dynamic>>('/home/data');
      return HomeDataModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch home data',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<bool> markNotificationAsRead(String notificationId) async {
    try {
      final response = await client.put<Map<String, dynamic>>(
        '/notifications/$notificationId/read',
      );
      return response.data?['success'] == true;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to mark notification as read',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
