import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/di/injection_container.dart' show sl;
import '../1_domain/repositories/hive_repository.dart';
import '../1_domain/usecases/get_hive_use_case.dart';
import '../1_domain/usecases/update_hive_use_case.dart';
import '../2_data/datasources/hive_local_data_source.dart';
import '../2_data/datasources/hive_remote_data_source.dart';
import '../2_data/repositories/hive_repository_impl.dart';

/// GetIt instance for dependency injection specific to profile feature
final GetIt profileInjection = GetIt.instance;

/// Initialize the profile feature dependencies
void initProfileFeature() {
  // Use cases
  profileInjection.registerLazySingleton(() => GetProfileUseCase(
    profileInjection<ProfileRepository>(),
  ));
  
  profileInjection.registerLazySingleton(() => UpdateProfileUseCase(
    profileInjection<ProfileRepository>(),
  ));
  
  // Repository
  profileInjection.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
    remoteDataSource: profileInjection<ProfileRemoteDataSource>(),
    localDataSource: profileInjection<ProfileLocalDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ));
  
  // Data sources
  profileInjection.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: sl()),
  );
  
  profileInjection.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(
      storageService: sl(),
      logger: sl<LoggerService>()
    ),
  );
}