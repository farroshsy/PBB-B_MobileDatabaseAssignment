import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../1_domain/entities/home_data.dart';

/// Card displaying a notification
class NotificationCard extends StatelessWidget {
  /// Creates a notification card
  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  /// Notification to display
  final NotificationItem notification;
  
  /// Optional tap callback
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, h:mm a');
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: notification.read
            ? BorderSide.none
            : BorderSide(color: theme.colorScheme.primary, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6, right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notification.read
                      ? Colors.transparent
                      : theme.colorScheme.primary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: notification.read
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormat.format(notification.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withAlpha(128),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
