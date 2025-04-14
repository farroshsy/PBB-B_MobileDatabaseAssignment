import '../../1_domain/entities/dashboard.dart';

/// Data model for Dashboard
class DashboardModel extends Dashboard {
  /// Creates a dashboard model
  const DashboardModel({
    required super.id,
    required super.name,
    required this.userId,
    required this.layout,
    this.createdAt,
    this.updatedAt,
  });

  /// ID of the user who owns this dashboard
  final String userId;
  
  /// Layout configuration for widgets
  final Map<String, dynamic> layout;
  
  /// When the dashboard was created
  final DateTime? createdAt;
  
  /// When the dashboard was last updated
  final DateTime? updatedAt;

  /// Creates a dashboard model from JSON
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      layout: json['layout'] as Map<String, dynamic>,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'layout': layout,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
