import '../../1_domain/entities/user.dart';

/// Data model for User domain entity
class UserModel extends User {
  /// Creates a UserModel
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
    this.createdAt,
    this.lastSignInAt,
  });

  /// When the user was created
  final DateTime? createdAt;
  
  /// When the user last signed in
  final DateTime? lastSignInAt;

  /// Creates a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      lastSignInAt: json['lastSignInAt'] != null 
          ? DateTime.parse(json['lastSignInAt'] as String) 
          : null,
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt?.toIso8601String(),
      'lastSignInAt': lastSignInAt?.toIso8601String(),
    };
  }

  /// Creates a copy of this model with the given fields replaced
  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return copyWithModel(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
  
  /// Creates a copy of this model with all fields replaceable
  UserModel copyWithModel({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastSignInAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }
}
