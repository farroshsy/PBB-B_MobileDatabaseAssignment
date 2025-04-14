import '../../1_domain/entities/home.dart';

/// Data model for Home
class HomeModel extends Home {
  /// Creates a HomeModel
  const HomeModel({
    required super.id,
    required super.name,
    this.createdAt,
    this.updatedAt,
  });

  /// When the home was created
  final DateTime? createdAt;
  
  /// When the home was last updated
  final DateTime? updatedAt;

  /// Creates a HomeModel from JSON
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
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
