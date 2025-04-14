import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import '../../1_domain/entities/notification.dart';

/// Notification list item
class NotificationListItem extends StatelessWidget {
  /// Creates a notification list item
  const NotificationListItem({
    super.key,
    required this.notification,
    this.onTap,
  });

  /// Notification to display
  final Notification notification;
  
  /// Optional tap callback
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timeFormat = DateFormat('h:mm a');
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: notification.read ? 0 : 1,
      color: notification.read 
          ? theme.cardColor 
          : theme.colorScheme.primary.withAlpha(13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: notification.read
            ? BorderSide(color: theme.dividerColor.withAlpha(26))
            : BorderSide(color: theme.colorScheme.primary.withAlpha(77)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildNotificationIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: notification.read
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeFormat.format(notification.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(153),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!notification.read)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notification.body,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNotificationIcon() {
    final iconData = _getIconForType(notification.type);
    final iconColor = _getColorForType(notification.type);
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withAlpha(26),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }
  
  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return Icons.system_update;
      case NotificationType.message:
        return Icons.message;
      case NotificationType.alert:
        return Icons.warning_amber;
      case NotificationType.promo:
        return Icons.local_offer;
      case NotificationType.general:
      default:
        return Icons.notifications;
    }
  }
  
  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return Colors.purple;
      case NotificationType.message:
        return Colors.blue;
      case NotificationType.alert:
        return Colors.orange;
      case NotificationType.promo:
        return Colors.green;
      case NotificationType.general:
      default:
        return Colors.grey;
    }
  }
}
