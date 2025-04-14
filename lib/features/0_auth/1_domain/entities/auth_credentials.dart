import 'package:equatable/equatable.dart';

/// Auth credentials domain entity
class AuthCredentials extends Equatable {
  /// Creates new auth credentials
  const AuthCredentials({
    required this.email,
    required this.password,
    this.displayName,
  });

  /// User email
  final String email;
  
  /// User password
  final String password;
  
  /// User display name (for sign up)
  final String? displayName;

  /// Creates a copy of the credentials with specified fields updated
  AuthCredentials copyWith({
    String? email,
    String? password,
    String? displayName,
  }) {
    return AuthCredentials(
      email: email ?? this.email,
      password: password ?? this.password,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  List<Object?> get props => [email, password, displayName];
  
  @override
  bool get stringify => true;
}