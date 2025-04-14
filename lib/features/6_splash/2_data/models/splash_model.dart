import '../../1_domain/entities/splash.dart';

/// Data model for Splash
class SplashModel extends Splash {
  /// Creates a SplashModel
  const SplashModel({
    required super.id,
    required super.name,
    this.createdAt,
    this.updatedAt,
  });

  /// When the splash was created
  final DateTime? createdAt;
  
  /// When the splash was last updated
  final DateTime? updatedAt;

  /// Creates a SplashModel from JSON
  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(
      id: json['id'] as String,
      name: json['name'] as String,
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
