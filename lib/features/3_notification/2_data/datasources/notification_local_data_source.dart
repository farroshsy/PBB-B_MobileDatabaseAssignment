import 'dart:convert';

import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/storage/storage_service.dart';
import 'package:my_app/core/services/logger_service.dart';
import '../models/notification_model.dart'; // Assuming this exists

/// Abstract interface for Notification feature local data source
abstract class NotificationLocalDataSource {
  Future<void> cacheNotifications(List<NotificationModel> notifications);
  Future<List<NotificationModel>> getCachedNotifications();
  Future<void> updateNotification(NotificationModel notification); // For marking as read/etc locally
  Future<void> deleteNotification(String id);
  Future<void> clearAll();
  // Add other methods if needed, e.g., for unread count if cached
  // Future<int> getUnreadCount();
}

/// Implementation using StorageService
class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final StorageService storageService;
  final LoggerService logger;

  static const _notificationsKey = 'CACHED_NOTIFICATIONS';

  NotificationLocalDataSourceImpl({
    required this.storageService,
    required this.logger,
  });

  @override
  Future<void> cacheNotifications(List<NotificationModel> notifications) async {
    try {
      final jsonList = notifications.map((model) => model.toJson()).toList();
      await storageService.saveValue(_notificationsKey, jsonEncode(jsonList));
    } catch (e) {
      throw CacheException(message: 'Failed to cache notifications: ${e.toString()}');
    }
  }

  @override
  Future<List<NotificationModel>> getCachedNotifications() async {
    try {
      final jsonString = await storageService.getValue(_notificationsKey) as String?;
      if (jsonString == null) {
        // Return empty list instead of throwing? Depends on requirements.
        return [];
        // throw CacheException(message: 'No cached notifications found');
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get cached notifications: ${e.toString()}');
    }
  }

  @override
  Future<void> updateNotification(NotificationModel notification) async {
     try {
      final notifications = await getCachedNotifications();
      final index = notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        notifications[index] = notification;
        await cacheNotifications(notifications);
      } else {
         logger.warning('Attempted to update non-cached notification (ID: ${notification.id})');
         // Optionally add it if not found? Depends on logic.
         // notifications.add(notification);
         // await cacheNotifications(notifications);
      }
    } catch (e) {
       throw CacheException(message: 'Failed to update notification locally: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteNotification(String id) async {
    try {
      final notifications = await getCachedNotifications();
      notifications.removeWhere((n) => n.id == id);
      await cacheNotifications(notifications);
    } catch (e) {
       throw CacheException(message: 'Failed to delete notification locally: ${e.toString()}');
    }
  }

   @override
  Future<void> clearAll() async {
     try {
      await storageService.removeValue(_notificationsKey);
    } catch (e) {
       throw CacheException(message: 'Failed to clear notifications locally: ${e.toString()}');
    }
  }

  // Example for cached unread count (if needed)
  // Future<int> getUnreadCount() async {
  //   try {
  //     final notifications = await getCachedNotifications();
  //     return notifications.where((n) => !n.read).length;
  //   } catch (e) {
  //      throw CacheException(message: 'Failed to get local unread count: ${e.toString()}');
  //   }
  // }
}
