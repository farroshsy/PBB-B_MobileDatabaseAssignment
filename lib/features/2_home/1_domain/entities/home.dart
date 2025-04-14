/// Home entity representing the core domain model for this feature
class Home {
  /// Creates a new Home entity
  const Home({
    required this.id,
    required this.name,
  });

  /// Unique identifier for the Home
  final String id;
  
  /// Name of the Home
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Home &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'Home(id: $id, name: $name)';
}
