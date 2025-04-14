import 'package:dio/dio.dart';
import 'package:my_app/core/error/exceptions.dart';
import '../../1_domain/entities/dashboard.dart';
import '../models/dashboard_model.dart';
import '../models/dashboard_stats_model.dart';

/// Remote data source for dashboard
abstract class DashboardRemoteDataSource {
  /// Get all dashboards
  Future<List<DashboardModel>> getDashboards();
  
  /// Get dashboard by ID
  Future<DashboardModel> getDashboardById(String id);
  
  /// Get dashboard statistics
  Future<DashboardStatsModel> getDashboardStats();
  
  /// Update dashboard
  Future<DashboardModel> updateDashboard(Dashboard dashboard);
}

/// Implementation of dashboard remote data source
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  /// Creates dashboard remote data source implementation
  const DashboardRemoteDataSourceImpl({required this.client});
  
  /// HTTP client
  final Dio client;
  
  @override
  Future<List<DashboardModel>> getDashboards() async {
    try {
      final response = await client.get<List<dynamic>>('/dashboards');
      return response.data!
          .map((json) => DashboardModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch dashboards',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<DashboardModel> getDashboardById(String id) async {
    try {
      final response = await client.get<Map<String, dynamic>>('/dashboards/$id');
      return DashboardModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch dashboard',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<DashboardStatsModel> getDashboardStats() async {
    try {
      final response = await client.get<Map<String, dynamic>>('/dashboard/stats');
      return DashboardStatsModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to fetch dashboard stats',
        statusCode: e.response?.statusCode,
      );
    }
  }
  
  @override
  Future<DashboardModel> updateDashboard(Dashboard dashboard) async {
    try {
      final response = await client.put<Map<String, dynamic>>(
        '/dashboards/${dashboard.id}',
        data: (dashboard as DashboardModel).toJson(),
      );
      return DashboardModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to update dashboard',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
