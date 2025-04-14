import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/storage/storage_service.dart';
import '../models/dashboard_model.dart';
import '../models/dashboard_stats_model.dart';
import 'dart:convert';

/// Local data source for dashboard
abstract class DashboardLocalDataSource {
  /// Cache multiple dashboard
  Future<void> cacheDashboards(List<DashboardModel> dashboards);
  
  /// Cache single dashboard
  Future<void> cacheDashboard(DashboardModel dashboard);
  
  /// Get cached dashboards
  Future<List<DashboardModel>> getCachedDashboards();
  
  /// Get cached dashboard by ID
  Future<DashboardModel> getCachedDashboardById(String id);
  
  /// Cache dashboard statistics
  Future<void> cacheDashboardStats(DashboardStatsModel stats);
  
  /// Get cached dashboard statistics
  Future<DashboardStatsModel> getCachedDashboardStats();
}

/// Implementation of dashboard local data source
class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  /// Creates dashboard local data source
  const DashboardLocalDataSourceImpl({required this.storageService});
  
  /// Storage service
  final StorageService storageService;
  
  static const _dashboardsKey = 'CACHED_DASHBOARDS';
  static const _dashboardStatsKey = 'CACHED_DASHBOARD_STATS';
  
  @override
  Future<void> cacheDashboards(List<DashboardModel> dashboards) async {
    try {
      final jsonList = dashboards.map((model) => model.toJson()).toList();
      await storageService.saveValue(_dashboardsKey, jsonEncode(jsonList));
    } catch (e) {
      throw CacheException(message: 'Failed to cache dashboards');
    }
  }
  
  @override
  Future<void> cacheDashboard(DashboardModel dashboard) async {
    try {
      // Get current cached dashboards
      List<DashboardModel> dashboards;
      try {
        dashboards = await getCachedDashboards();
      } on CacheException {
        dashboards = [];
      }
      
      // Find and replace or add the dashboard
      final index = dashboards.indexWhere((d) => d.id == dashboard.id);
      if (index >= 0) {
        dashboards[index] = dashboard;
      } else {
        dashboards.add(dashboard);
      }
      
      await cacheDashboards(dashboards);
    } catch (e) {
      throw CacheException(message: 'Failed to cache dashboard');
    }
  }
  
  @override
  Future<List<DashboardModel>> getCachedDashboards() async {
    try {
      final jsonString = await storageService.getValue(_dashboardsKey) as String?;
      if (jsonString == null) {
        throw CacheException(message: 'No cached dashboards found');
      }
      
      final List<dynamic> jsonList = jsonDecode(jsonString);
      
      return jsonList
          .map((json) => DashboardModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get cached dashboards: ${e.toString()}');
    }
  }
  
  @override
  Future<DashboardModel> getCachedDashboardById(String id) async {
    try {
      final dashboards = await getCachedDashboards();
      final dashboard = dashboards.firstWhere((d) => d.id == id);
      return dashboard;
    } catch (e) {
      throw CacheException(message: 'Dashboard with ID $id not found in cache');
    }
  }
  
  @override
  Future<void> cacheDashboardStats(DashboardStatsModel stats) async {
    try {
      await storageService.saveValue(_dashboardStatsKey, jsonEncode(stats.toJson()));
    } catch (e) {
      throw CacheException(message: 'Failed to cache dashboard stats');
    }
  }
  
  @override
  Future<DashboardStatsModel> getCachedDashboardStats() async {
    try {
      final jsonString = await storageService.getValue(_dashboardStatsKey) as String?;
      if (jsonString == null) {
        throw CacheException(message: 'No cached dashboard stats found');
      }
      
      final Map<String, dynamic> json = jsonDecode(jsonString);
      
      return DashboardStatsModel.fromJson(json);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached dashboard stats: ${e.toString()}');
    }
  }
}
