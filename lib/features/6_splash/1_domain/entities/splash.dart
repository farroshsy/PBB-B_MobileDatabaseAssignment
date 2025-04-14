/// Splash entity representing the core domain model for this feature
class Splash {
  /// Creates a new Splash entity
  const Splash({
    required this.id,
    required this.name,
  });

  /// Unique identifier for the Splash
  final String id;
  
  /// Name of the Splash
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Splash &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'Splash(id: $id, name: $name)';
}
