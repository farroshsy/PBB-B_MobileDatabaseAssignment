/// Profile entity representing user profile information
class Profile {
  /// Creates a profile entity
  const Profile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.bio,
    this.phoneNumber,
    this.address,
    this.preferences = const {},
  });

  /// Unique user ID
  final String id;
  
  /// User's display name
  final String name;
  
  /// User's email address
  final String email;
  
  /// URL to user's profile photo (optional)
  final String? photoUrl;
  
  /// User's biography (optional)
  final String? bio;
  
  /// User's phone number (optional)
  final String? phoneNumber;
  
  /// User's address (optional)
  final String? address;
  
  /// User preferences as key-value pairs
  final Map<String, dynamic> preferences;

  /// Creates a copy of this profile with modified fields
  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? bio,
    String? phoneNumber,
    String? address,
    Map<String, dynamic>? preferences,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Profile &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.photoUrl == photoUrl &&
      other.bio == bio &&
      other.phoneNumber == phoneNumber &&
      other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      bio.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode;
  }
}
