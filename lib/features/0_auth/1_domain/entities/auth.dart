import 'package:equatable/equatable.dart';

/// Entity class for Auth feature
class Auth extends Equatable {
  /// Unique identifier
  final String id;
  
  /// Name or title
  final String name;
  
  /// Creation timestamp
  final DateTime createdAt;

  /// Creates a new [Auth]
  const Auth({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  
  /// Creates a copy of the auth with specified fields updated
  Auth copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
  }) {
    return Auth(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt];
  
  @override
  bool get stringify => true;
}
