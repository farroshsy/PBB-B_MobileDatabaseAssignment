import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Get all notifications use case
class GetNotificationsUseCase implements UseCase<List<Notification>, NoParams> {
  /// Creates a get notifications use case
  const GetNotificationsUseCase(this._notificationRepository);

  final NotificationRepository _notificationRepository;

  @override
  Future<Either<Failure, List<Notification>>> call(NoParams params) {
    return _notificationRepository.getNotifications();
  }
}
