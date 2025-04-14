/* // Temporarily commenting out entire file content due to persistent compiler issues
import 'package:get_it/get_it.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/di/injection_container.dart' show sl;
import '../1_domain/repositories/settings_repository.dart';
import '../1_domain/usecases/get_settings_use_case.dart';
import '../1_domain/usecases/update_settings_use_case.dart';
import '../2_data/datasources/setting_remote_data_source.dart';
import 'package:my_app/features/5_setting/2_data/repositories/setting_repo_impl.dart';
import 'package:dio/dio.dart';
// import '../core/network/dio_client.dart'; 

/// GetIt instance for dependency injection specific to setting feature
final GetIt settingInjection = GetIt.instance;

/// Initialize the setting feature dependencies
void initSettingFeature() {
  // Use cases
  settingInjection.registerLazySingleton<GetSettingsUseCase>(() => GetSettingsUseCase(
    settingInjection<SettingsRepository>(),
  ));
  
  settingInjection.registerLazySingleton<UpdateSettingsUseCase>(() => UpdateSettingsUseCase(
    settingInjection<SettingsRepository>(),
  ));
  
  // Repository
  settingInjection.registerLazySingleton<SettingsRepository>(() => SettingRepoImpl(
    remoteDataSource: settingInjection<SettingRemoteDataSource>(),
    networkInfo: GetIt.instance<NetworkInfo>(), 
  ));
  
  // Data sources
  settingInjection.registerLazySingleton<SettingRemoteDataSource>(
    () => SettingRemoteDataSourceImpl(client: GetIt.instance<Dio>()), 
  );
}
*/

import 'package:get_it/get_it.dart';
// Keep imports commented for things used only inside the commented block
/*
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/di/injection_container.dart' show sl;
import '../1_domain/repositories/settings_repository.dart';
import '../1_domain/usecases/get_settings_use_case.dart';
import '../1_domain/usecases/update_settings_use_case.dart';
import '../2_data/datasources/setting_remote_data_source.dart';
import 'package:my_app/features/5_setting/2_data/repositories/setting_repo_impl.dart'; 
import 'package:dio/dio.dart';
// import '../core/network/dio_client.dart'; 
*/

/// GetIt instance for dependency injection specific to setting feature
// This definition MUST exist for providers that reference it.
final GetIt settingInjection = GetIt.instance;

/// Initialize the setting feature dependencies
// Keep the function definition but leave the body commented out.
void initSettingFeature() {
/* // Keep registrations commented out
  // Use cases
  settingInjection.registerLazySingleton<GetSettingsUseCase>(() => GetSettingsUseCase(
    settingInjection<SettingsRepository>(),
  ));
  
  settingInjection.registerLazySingleton<UpdateSettingsUseCase>(() => UpdateSettingsUseCase(
    settingInjection<SettingsRepository>(),
  ));
  
  // Repository
  settingInjection.registerLazySingleton<SettingsRepository>(() => SettingRepoImpl(
    remoteDataSource: settingInjection<SettingRemoteDataSource>(),
    networkInfo: GetIt.instance<NetworkInfo>(), 
  ));
  
  // Data sources
  settingInjection.registerLazySingleton<SettingRemoteDataSource>(
    () => SettingRemoteDataSourceImpl(client: GetIt.instance<Dio>()), 
  );
*/
}