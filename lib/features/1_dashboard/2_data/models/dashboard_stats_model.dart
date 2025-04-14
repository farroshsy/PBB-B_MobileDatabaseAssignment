import '../../1_domain/entities/dashboard_stats.dart';

/// Data model for dashboard statistics
class DashboardStatsModel extends DashboardStats {
  /// Creates dashboard statistics model
  const DashboardStatsModel({
    required super.totalUsers,
    required super.activeUsers,
    required super.totalRevenue,
    required super.period,
    super.growthRate,
    super.topPerformers,
    this.timestamp,
  });

  /// When these statistics were generated
  final DateTime? timestamp;

  /// Creates dashboard statistics model from JSON
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalUsers: json['totalUsers'] as int,
      activeUsers: json['activeUsers'] as int,
      totalRevenue: json['totalRevenue'] as double,
      period: json['period'] as String,
      growthRate: json['growthRate'] as double?,
      topPerformers: (json['topPerformers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'] as String) 
          : null,
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalUsers': totalUsers,
      'activeUsers': activeUsers,
      'totalRevenue': totalRevenue,
      'period': period,
      'growthRate': growthRate,
      'topPerformers': topPerformers,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
