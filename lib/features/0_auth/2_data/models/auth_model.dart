import '../../1_domain/entities/auth.dart';

/// Data model for auth that extends the domain entity
class AuthModel extends Auth {
  /// Creates a new [AuthModel]
  const AuthModel({
    required super.id,
    required super.name,
    required super.createdAt,
  });

  /// Create a model from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create a copy of this model with some fields changed
  @override
  AuthModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return AuthModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
