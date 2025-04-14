import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/di/injection_container.dart' show sl;
import '../1_domain/repositories/notification_repository.dart';
import '../1_domain/usecases/get_notifications_use_case.dart';
import '../1_domain/usecases/get_unread_count_use_case.dart';
import '../1_domain/usecases/mark_as_read_use_case.dart';
import '../2_data/datasources/notification_local_data_source.dart';
import '../2_data/datasources/notification_remote_data_source.dart';
import '../2_data/repositories/notification_repository_impl.dart';

/// GetIt instance for dependency injection specific to notification feature
final GetIt notificationInjection = GetIt.instance;

/// Initialize the notification feature dependencies
void initNotificationFeature() {
  // Use cases
  notificationInjection.registerLazySingleton(() => GetNotificationsUseCase(
    notificationInjection<NotificationRepository>(),
  ));
  
  notificationInjection.registerLazySingleton(() => GetUnreadCountUseCase(
    notificationInjection<NotificationRepository>(),
  ));
  
  notificationInjection.registerLazySingleton(() => MarkAsReadUseCase(
    notificationInjection<NotificationRepository>(),
  ));
  
  // Repository
  notificationInjection.registerLazySingleton<NotificationRepository>(() => NotificationRepositoryImpl(
    remoteDataSource: notificationInjection<NotificationRemoteDataSource>(),
    localDataSource: notificationInjection<NotificationLocalDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ));
  
  // Data sources
  notificationInjection.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(client: sl()),
  );
  
  notificationInjection.registerLazySingleton<NotificationLocalDataSource>(
    () => NotificationLocalDataSourceImpl(
      storageService: sl(),
      logger: sl<LoggerService>()
    ),
  );
}