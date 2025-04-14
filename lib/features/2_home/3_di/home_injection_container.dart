import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/di/injection_container.dart' show sl;
import '../1_domain/repositories/home_repository.dart';
import '../1_domain/usecases/get_home_data_use_case.dart';
import '../1_domain/usecases/get_home_details_use_case.dart';
import '../2_data/datasources/home_local_data_source.dart';
import '../2_data/datasources/home_remote_data_source.dart';
import '../2_data/repositories/home_repository_impl.dart';

/// GetIt instance for dependency injection specific to home feature
final GetIt homeInjection = GetIt.instance;

/// Initialize the home feature dependencies
void initHomeFeature() {
  // Use cases
  homeInjection.registerLazySingleton(() => GetHomeDataUseCase(
    homeInjection<HomeRepository>(),
  ));
  
  // Add any additional use cases
  homeInjection.registerLazySingleton(() => GetHomeDetailsUseCase(
    homeInjection<HomeRepository>(),
  ));
  
  // Repository
  homeInjection.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
    remoteDataSource: homeInjection<HomeRemoteDataSource>(),
    localDataSource: homeInjection<HomeLocalDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ));
  
  // Data sources
  homeInjection.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
  );
  
  homeInjection.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      storageService: sl(),
      logger: sl<LoggerService>()
    ),
  );
}