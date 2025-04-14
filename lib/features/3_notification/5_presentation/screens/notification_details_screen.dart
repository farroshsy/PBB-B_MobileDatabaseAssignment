import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../4_providers/notification_provider.dart';
import '../../1_domain/entities/notification.dart' as notification_entity;

/// Notification details screen showing a single notification
class NotificationDetailsScreen extends ConsumerWidget {
  /// Creates a notification details screen
  const NotificationDetailsScreen({
    super.key,
    required this.id,
  });

  /// ID of the notification to display
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    
    // Use the alias when referring to the Notification entity
    notification_entity.Notification? notification;
    for (final n in notificationState.notifications) {
      if (n.id == id) {
        notification = n;
        break;
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: PageContainer(
        child: notification == null
          ? const Center(child: Text('Notification not found'))
          : _buildNotificationDetails(context, notification),
      ),
    );
  }

  // Helper widget builder when notification is guaranteed non-null
  Widget _buildNotificationDetails(BuildContext context, notification_entity.Notification notification) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                _getNotificationTypeIcon(notification.type),
                size: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                _formatNotificationType(notification.type),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(notification.createdAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Divider(height: 32),
          Text(
            notification.body,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (notification.actionPayload != null) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle action based on payload
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Action triggered: ${notification.actionPayload}'),
                  ),
                );
              },
              child: const Text('Take Action'),
            ),
          ],
        ],
      ),
    );
  }
  
  // Use alias for NotificationType enum in method signature and switch cases
  IconData _getNotificationTypeIcon(notification_entity.NotificationType type) {
    switch (type) {
      case notification_entity.NotificationType.general:
        return Icons.notifications;
      case notification_entity.NotificationType.system:
        return Icons.settings;
      case notification_entity.NotificationType.message:
        return Icons.message;
      case notification_entity.NotificationType.alert:
        return Icons.warning;
      case notification_entity.NotificationType.promo:
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }
  
  // Use alias for NotificationType enum in method signature and switch cases
  String _formatNotificationType(notification_entity.NotificationType type) {
    switch (type) {
      case notification_entity.NotificationType.general:
        return 'General';
      case notification_entity.NotificationType.system:
        return 'System';
      case notification_entity.NotificationType.message:
        return 'Message';
      case notification_entity.NotificationType.alert:
        return 'Alert';
      case notification_entity.NotificationType.promo:
        return 'Promotion';
      default:
        return 'General';
    }
  }
  
  String _formatDate(DateTime date) {
    // Simple formatting - in a real app would use intl package
    return '${date.day}/${date.month}/${date.year}';
  }
}