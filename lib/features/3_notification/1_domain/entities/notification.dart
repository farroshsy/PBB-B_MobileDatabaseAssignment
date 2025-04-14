/// Notification entity representing a user notification
class Notification {
  /// Creates a notification entity
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.type = NotificationType.general,
    this.read = false,
    this.actionPayload,
  });

  /// Unique ID
  final String id;
  
  /// Notification title
  final String title;
  
  /// Notification content
  final String body;
  
  /// When notification was created
  final DateTime createdAt;
  
  /// Type of notification
  final NotificationType type;
  
  /// Whether notification has been read
  final bool read;
  
  /// Optional payload for action handling
  final Map<String, dynamic>? actionPayload;

  /// Creates a copy with modified fields
  Notification copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? createdAt,
    NotificationType? type,
    bool? read,
    Map<String, dynamic>? actionPayload,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      read: read ?? this.read,
      actionPayload: actionPayload ?? this.actionPayload,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Notification &&
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.createdAt == createdAt &&
      other.type == type &&
      other.read == read;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      createdAt.hashCode ^
      type.hashCode ^
      read.hashCode;
  }
}

/// Types of notifications
enum NotificationType {
  /// General notification
  general,
  
  /// System notification
  system,
  
  /// Message notification
  message,
  
  /// Alert notification
  alert,
  
  /// Promotional notification
  promo,
}
