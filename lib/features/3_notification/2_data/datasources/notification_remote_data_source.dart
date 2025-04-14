import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../models/notification_model.dart';

/// Notification remote data source interface
abstract class NotificationRemoteDataSource {
  /// Get all notification items
  Future<List<NotificationModel>> getAll();

  /// Get notification by ID
  Future<NotificationModel> getById(String id);
}

/// Implementation of [NotificationRemoteDataSource] using Dio HTTP client
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  /// Creates a notification remote data source
  const NotificationRemoteDataSourceImpl({
    required this.client,
  });

  /// The HTTP client
  final Dio client;

  @override
  Future<List<NotificationModel>> getAll() async {
    try {
      final response = await client.get<List<dynamic>>('/api/notifications');
      
      return response.data!
        .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
        .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get notifications',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<NotificationModel> getById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/api/notifications/$id');
      
      return NotificationModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get notification',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
