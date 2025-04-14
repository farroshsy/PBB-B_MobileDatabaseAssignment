import '../../1_domain/entities/notification.dart';

/// Data model for notification
class NotificationModel extends Notification {
  /// Creates a notification model
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.createdAt,
    super.type,
    super.read,
    super.actionPayload,
    this.updatedAt,
  });

  /// When notification was last updated
  final DateTime? updatedAt;

  /// Creates a notification model from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      type: _notificationTypeFromString(json['type'] as String?),
      read: json['read'] as bool? ?? false,
      actionPayload: json['actionPayload'] as Map<String, dynamic>?,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'type': _notificationTypeToString(type),
      'read': read,
      'actionPayload': actionPayload,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Creates a copy with modified fields
  NotificationModel copyWithModel({
    String? id,
    String? title,
    String? body,
    DateTime? createdAt,
    NotificationType? type,
    bool? read,
    Map<String, dynamic>? actionPayload,
    DateTime? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      read: read ?? this.read,
      actionPayload: actionPayload ?? this.actionPayload,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Converts notification type enum to string
  static String _notificationTypeToString(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return 'system';
      case NotificationType.message:
        return 'message';
      case NotificationType.alert:
        return 'alert';
      case NotificationType.promo:
        return 'promo';
      case NotificationType.general:
      default:
        return 'general';
    }
  }
  
  /// Converts string to notification type enum
  static NotificationType _notificationTypeFromString(String? value) {
    switch (value) {
      case 'system':
        return NotificationType.system;
      case 'message':
        return NotificationType.message;
      case 'alert':
        return NotificationType.alert;
      case 'promo':
        return NotificationType.promo;
      case 'general':
      default:
        return NotificationType.general;
    }
  }
}
