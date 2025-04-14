import '../../1_domain/entities/profile.dart';

/// Data model for Profile
class ProfileModel extends Profile {
  /// Creates a profile model
  const ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    super.photoUrl,
    super.bio,
    super.phoneNumber,
    super.address,
    super.preferences,
    this.createdAt,
    this.updatedAt,
  });

  /// When profile was created
  final DateTime? createdAt;
  
  /// When profile was last updated
  final DateTime? updatedAt;

  /// Creates a profile model from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>? ?? {},
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
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'phoneNumber': phoneNumber,
      'address': address,
      'preferences': preferences,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Creates a copy of this model with the given fields replaced
  ProfileModel copyWithModel({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    String? phoneNumber,
    String? address,
    Map<String, dynamic>? preferences,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
