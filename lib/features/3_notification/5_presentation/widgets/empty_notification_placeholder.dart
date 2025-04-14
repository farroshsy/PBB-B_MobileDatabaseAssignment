import 'package:flutter/material.dart';

/// Placeholder for empty notification list
class EmptyNotificationPlaceholder extends StatelessWidget {
  /// Creates an empty notification placeholder
  const EmptyNotificationPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: Theme.of(context).disabledColor.withAlpha(128),
          ),
          const SizedBox(height: 16),
          Text(
            'No Notifications',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any notifications yet.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(179),
            ),
          ),
        ],
      ),
    );
  }
}
