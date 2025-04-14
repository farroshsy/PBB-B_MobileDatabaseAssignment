import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../4_providers/notification_provider.dart';
import '../widgets/empty_notification_placeholder.dart';
import '../widgets/notification_list_item.dart';
import 'notification_details_screen.dart';

/// Notifications screen showing list of notifications
class NotificationsScreen extends ConsumerStatefulWidget {
  /// Creates a notifications screen
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the data loading until after the first frame
    Future.microtask(() => _loadNotifications());
  }
  
  Future<void> _loadNotifications() async {
    // Check if mounted
    if (mounted) { 
      await ref.read(notificationProvider.notifier).loadNotifications();
    }
  }
  
  void _viewNotificationDetails(String id) {
    ref.read(notificationProvider.notifier).selectNotification(id);
    ref.read(notificationProvider.notifier).markAsRead(id);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationDetailsScreen(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationProvider);
    
    return PageContainer(
      scrollable: false,
      child: state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : _buildNotificationList(state),
    );
  }
  
  Widget _buildNotificationList(NotificationState state) {
    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (state.notifications.isEmpty) {
      return const EmptyNotificationPlaceholder();
    }
    
    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return NotificationListItem(
            notification: notification,
            onTap: () => _viewNotificationDetails(notification.id),
          );
        },
      ),
    );
  }
}