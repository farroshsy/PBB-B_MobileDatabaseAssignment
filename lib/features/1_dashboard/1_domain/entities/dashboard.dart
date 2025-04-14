import 'package:equatable/equatable.dart';

/// Dashboard entity representing the core domain model for this feature
class Dashboard extends Equatable {
  /// Creates a new Dashboard entity
  const Dashboard({
    required this.id,
    required this.name,
  });

  /// Unique identifier for the Dashboard
  final String id;
  
  /// Name of the Dashboard
  final String name;

  /// Creates a copy of the dashboard with specified fields updated
  Dashboard copyWith({
    String? id,
    String? name,
  }) {
    return Dashboard(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name];
  
  @override
  bool get stringify => true;
}
