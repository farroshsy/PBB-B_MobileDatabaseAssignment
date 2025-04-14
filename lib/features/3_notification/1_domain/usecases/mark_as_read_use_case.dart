import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Mark as read use case parameters
class MarkAsReadParams {
  /// Creates mark as read parameters
  const MarkAsReadParams({required this.id});
  
  /// Notification ID
  final String id;
}

/// Mark notification as read use case
class MarkAsReadUseCase implements UseCase<Notification, MarkAsReadParams> {
  /// Creates a mark as read use case
  const MarkAsReadUseCase(this._notificationRepository);

  final NotificationRepository _notificationRepository;

  @override
  Future<Either<Failure, Notification>> call(MarkAsReadParams params) {
    return _notificationRepository.markAsRead(params.id);
  }
}
