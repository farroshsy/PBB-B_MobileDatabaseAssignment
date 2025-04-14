/// Setting entity representing the core domain model for this feature
class Setting {
  /// Creates a new Setting entity
  const Setting({
    required this.id,
    required this.name,
  });

  /// Unique identifier for the Setting
  final String id;
  
  /// Name of the Setting
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Setting &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'Setting(id: $id, name: $name)';
}
