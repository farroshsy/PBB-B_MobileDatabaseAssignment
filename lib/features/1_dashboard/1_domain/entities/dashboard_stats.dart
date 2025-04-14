/// Dashboard statistics entity representing analytics and metrics
class DashboardStats {
  /// Creates dashboard statistics
  const DashboardStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.totalRevenue,
    required this.period,
    this.growthRate,
    this.topPerformers = const [],
  });

  /// Total number of users
  final int totalUsers;
  
  /// Number of currently active users
  final int activeUsers;
  
  /// Total revenue amount
  final double totalRevenue;
  
  /// Period for these statistics (e.g., 'daily', 'weekly', 'monthly')
  final String period;
  
  /// Growth rate percentage compared to previous period (optional)
  final double? growthRate;
  
  /// List of top performing metrics (optional)
  final List<String> topPerformers;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DashboardStats &&
      other.totalUsers == totalUsers &&
      other.activeUsers == activeUsers &&
      other.totalRevenue == totalRevenue &&
      other.period == period &&
      other.growthRate == growthRate;
  }

  @override
  int get hashCode {
    return totalUsers.hashCode ^
      activeUsers.hashCode ^
      totalRevenue.hashCode ^
      period.hashCode ^
      growthRate.hashCode;
  }
}
