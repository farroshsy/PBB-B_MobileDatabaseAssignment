import '../../1_domain/entities/setting.dart';

/// Data model for Setting
class SettingModel extends Setting {
  /// Creates a SettingModel
  const SettingModel({
    required super.id,
    required super.name,
    this.createdAt,
    this.updatedAt,
  });

  /// When the setting was created
  final DateTime? createdAt;
  
  /// When the setting was last updated
  final DateTime? updatedAt;

  /// Creates a SettingModel from JSON
  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
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
