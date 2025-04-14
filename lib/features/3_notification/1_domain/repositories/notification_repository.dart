import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import '../entities/notification.dart';

/// Notification repository interface in the domain layer
abstract class NotificationRepository {
  /// Get all notifications
  Future<Either<Failure, List<Notification>>> getNotifications();

  /// Get unread notifications count
  Future<Either<Failure, int>> getUnreadCount();
  
  /// Mark notification as read
  Future<Either<Failure, Notification>> markAsRead(String id);
  
  /// Mark all notifications as read
  Future<Either<Failure, int>> markAllAsRead();
  
  /// Delete notification
  Future<Either<Failure, bool>> deleteNotification(String id);
  
  /// Clear all notifications
  Future<Either<Failure, bool>> clearAll();
}
