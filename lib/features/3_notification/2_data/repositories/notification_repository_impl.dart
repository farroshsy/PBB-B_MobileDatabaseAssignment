import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import '../../1_domain/entities/notification.dart' as notification_entity;
import '../../1_domain/repositories/notification_repository.dart';
import '../datasources/notification_local_data_source.dart';
import '../datasources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final NotificationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<notification_entity.Notification>>> getNotifications() async {
    // --- MOCK IMPLEMENTATION START ---
    print("Repository: Returning Mock Notifications");
    await Future.delayed(const Duration(milliseconds: 600));

    final mockNotifications = [
      notification_entity.Notification(
        id: 'notif-101',
        title: 'System Update Available',
        body: 'A new system update is ready to be installed. Please restart your app.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        type: notification_entity.NotificationType.system,
      ),
      notification_entity.Notification(
        id: 'notif-102',
        title: 'New Message from Support',
        body: 'We have responded to your recent support ticket regarding...',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        type: notification_entity.NotificationType.message,
        read: true, // Mark one as read
      ),
       notification_entity.Notification(
        id: 'notif-103',
        title: 'Security Alert',
        body: 'Unusual login activity detected from a new device. Was this you?',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        type: notification_entity.NotificationType.alert,
      ),
      notification_entity.Notification(
        id: 'notif-104',
        title: 'Weekend Promotion!',
        body: 'Get 20% off all items this weekend only. Use code WEEKEND20.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        type: notification_entity.NotificationType.promo,
      ),
    ];

    return Right(mockNotifications);
    // --- MOCK IMPLEMENTATION END ---
    
    /* // Original Implementation
    if (await networkInfo.isConnected) {
      // ... 
    } else {
      // ...
    }
    */
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    print("Repository: Returning Mock Unread Count (2)");
    await Future.delayed(const Duration(milliseconds: 50));
    return const Right(2); // Mock 2 unread notifications
  }

  @override
  Future<Either<Failure, notification_entity.Notification>> markAsRead(String id) async {
     print("Repository: Mock markAsRead for ID: $id");
     await Future.delayed(const Duration(milliseconds: 100));
     // Find a mock notification to return, or create one
     final mockReadNotification = notification_entity.Notification(
        id: id, 
        title: 'Notification Marked Read', 
        body: 'Body for $id', 
        createdAt: DateTime.now(),
        read: true,
      );
     return Right(mockReadNotification);
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    return Left(ServerFailure(message: 'markAllAsRead not implemented'));
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(String id) async {
    return Left(ServerFailure(message: 'deleteNotification not implemented'));
  }

  @override
  Future<Either<Failure, bool>> clearAll() async {
    return Left(ServerFailure(message: 'clearAll not implemented'));
  }
}
