import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../repositories/notification_repository.dart';

/// Get unread notifications count use case
class GetUnreadCountUseCase implements UseCase<int, NoParams> {
  /// Creates a get unread count use case
  const GetUnreadCountUseCase(this._notificationRepository);

  final NotificationRepository _notificationRepository;

  @override
  Future<Either<Failure, int>> call(NoParams params) {
    return _notificationRepository.getUnreadCount();
  }
}
