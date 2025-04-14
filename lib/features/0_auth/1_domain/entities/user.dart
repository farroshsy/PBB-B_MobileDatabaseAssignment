import 'package:equatable/equatable.dart';

/// User domain entity
class User extends Equatable {
  /// Creates a new user entity
  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  /// User ID
  final String id;
  
  /// User email
  final String email;
  
  /// User display name
  final String? displayName;
  
  /// User photo URL
  final String? photoUrl;

  /// Creates a copy of the user with specified fields updated
  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object?> get props => [id, email, displayName, photoUrl];
  
  @override
  bool get stringify => true;
}