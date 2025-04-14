import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/network_info.dart';
import '../1_domain/repositories/dashboard_repository.dart';
import '../1_domain/usecases/get_dashboard_stats_use_case.dart';
import '../1_domain/usecases/get_dashboard_details_use_case.dart';
import '../2_data/datasources/dashboard_local_data_source.dart';
import '../2_data/datasources/dashboard_remote_data_source.dart';
import '../2_data/repositories/dashboard_repository_impl.dart';

/// GetIt instance for dependency injection
final GetIt dashboardInjection = GetIt.instance;

/// Initialize the dashboard feature dependencies
void initDashboardFeature() {
  // Use cases
  dashboardInjection.registerLazySingleton(() => GetDashboardStatsUseCase(
    dashboardInjection<DashboardRepository>(),
  ));
  
  dashboardInjection.registerLazySingleton(() => GetDashboardDetailsUseCase(
    dashboardInjection<DashboardRepository>(),
  ));
  
  // Repository
  dashboardInjection.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(
    remoteDataSource: dashboardInjection<DashboardRemoteDataSource>(),
    localDataSource: dashboardInjection<DashboardLocalDataSource>(),
    networkInfo: dashboardInjection<NetworkInfo>(),
  ));
  
  // Data sources
  dashboardInjection.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(client: dashboardInjection()),
  );
  
  dashboardInjection.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(storageService: dashboardInjection()),
  );
}