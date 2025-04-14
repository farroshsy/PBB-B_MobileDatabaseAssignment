import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/features/5_setting/1_domain/entities/app_settings.dart' as settings_entity;
import 'package:my_app/features/5_setting/1_domain/entities/setting.dart';
import 'package:my_app/features/5_setting/1_domain/usecases/get_settings_use_case.dart';
import 'package:my_app/features/5_setting/1_domain/usecases/update_settings_use_case.dart';
import 'package:flutter/material.dart' as material;

/// Settings state class containing all state information
class SettingsState {
  /// Creates a settings state
  const SettingsState({
    this.settings,
    this.isLoading = false,
    this.errorMessage,
    this.isUpdating = false,
  });

  /// App settings data
  final settings_entity.AppSettings? settings;
  
  /// Whether settings are loading
  final bool isLoading;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Whether settings are being updated
  final bool isUpdating;

  /// Creates a copy of the state with specified fields updated
  SettingsState copyWith({
    settings_entity.AppSettings? settings,
    bool? isLoading,
    String? errorMessage,
    bool? isUpdating,
    bool clearError = false,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
  
  /// Get theme mode
  settings_entity.ThemeMode get themeMode => settings?.themeMode ?? settings_entity.ThemeMode.system;
  
  /// Get locale string
  String get locale => settings?.locale ?? 'en_US';
  
  /// Check if notifications are enabled
  bool get areNotificationsEnabled => settings?.notificationsEnabled ?? true;
  
  /// Check if font scale is custom
  bool get hasCustomFontScale => (settings?.fontScale ?? 1.0) != 1.0;

  /// Get language code from locale
  String get languageCode => (settings?.locale ?? 'en_US').split('_').first;
}

/// Settings State Notifier that manages the settings state
class SettingsStateNotifier extends StateNotifier<SettingsState> {
  /// Creates a settings state notifier
  SettingsStateNotifier({
    required GetSettingsUseCase getSettingsUseCase,
    required UpdateSettingsUseCase updateSettingsUseCase,
  }) : _getSettingsUseCase = getSettingsUseCase,
       _updateSettingsUseCase = updateSettingsUseCase,
       super(const SettingsState());

  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  /// Load app settings
  Future<bool> loadSettings() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getSettingsUseCase(NoParams());

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (settings) {
        state = state.copyWith(
          settings: settings,
          isLoading: false,
        );
        return true;
      },
    );
  }
  
  /// Update app settings
  Future<bool> updateSettings(settings_entity.AppSettings updatedSettings) async {
    state = state.copyWith(isUpdating: true, clearError: true);

    final result = await _updateSettingsUseCase(
      UpdateSettingsParams(settings: updatedSettings),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isUpdating: false,
        );
        return false;
      },
      (settings) {
        state = state.copyWith(
          settings: settings,
          isUpdating: false,
        );
        return true;
      },
    );
  }
  
  /// Update theme mode
  Future<bool> updateThemeMode(settings_entity.ThemeMode themeMode) async {
    if (state.settings == null) return false;
    
    final currentSettings = state.settings!;
    settings_entity.AppSettings updatedAppSettings;
    switch(themeMode) {
      case settings_entity.ThemeMode.light:
         updatedAppSettings = currentSettings.copyWith(themeMode: settings_entity.ThemeMode.light);
         break;
      case settings_entity.ThemeMode.dark:
         updatedAppSettings = currentSettings.copyWith(themeMode: settings_entity.ThemeMode.dark);
         break;
      case settings_entity.ThemeMode.system:
      default:
         updatedAppSettings = currentSettings.copyWith(themeMode: settings_entity.ThemeMode.system);
         break;
    }
    
    return updateSettings(updatedAppSettings);
  }
  
  /// Update locale
  Future<bool> updateLocale(String locale) async {
    if (state.settings == null) return false;
    
    final updatedSettings = state.settings!.copyWith(locale: locale);
    return updateSettings(updatedSettings);
  }
  
  /// Toggle notifications
  Future<bool> toggleNotifications(bool enabled) async {
    if (state.settings == null) return false;
    
    final updatedSettings = state.settings!.copyWith(notificationsEnabled: enabled);
    return updateSettings(updatedSettings);
  }
  
  /// Toggle push notifications
  Future<bool> togglePushNotifications(bool enabled) async {
    if (state.settings == null) return false;
    
    final updatedSettings = state.settings!.copyWith(pushNotificationsEnabled: enabled);
    return updateSettings(updatedSettings);
  }
  
  /// Toggle email notifications
  Future<bool> toggleEmailNotifications(bool enabled) async {
    if (state.settings == null) return false;
    
    final updatedSettings = state.settings!.copyWith(emailNotificationsEnabled: enabled);
    return updateSettings(updatedSettings);
  }
  
  /// Update font scale
  Future<bool> updateFontScale(double scale) async {
    if (state.settings == null) return false;
    
    final updatedSettings = state.settings!.copyWith(fontScale: scale);
    return updateSettings(updatedSettings);
  }
}

/// Placeholder UseCase that does nothing (or returns default values)
class PlaceholderGetSettingsUseCase implements GetSettingsUseCase {
  @override
  Future<Either<Failure, settings_entity.AppSettings>> call(NoParams params) async {
    print("PlaceholderGetSettingsUseCase called");
    await Future.delayed(const Duration(milliseconds: 50));
    return const Right(settings_entity.AppSettings(themeMode: settings_entity.ThemeMode.system, locale: 'en_US'));
  }
}

class PlaceholderUpdateSettingsUseCase implements UpdateSettingsUseCase {
   @override
  Future<Either<Failure, settings_entity.AppSettings>> call(UpdateSettingsParams params) async {
     print("PlaceholderUpdateSettingsUseCase called");
     await Future.delayed(const Duration(milliseconds: 50));
     return const Right(settings_entity.AppSettings(themeMode: settings_entity.ThemeMode.system, locale: 'en_US'));
   }
}

// Keep the provider definition
final settingsProvider = StateNotifierProvider<SettingsStateNotifier, SettingsState>((ref) {
  print("WARNING: Using placeholder use cases for Settings due to DI issue.");
  // Use placeholder use cases instead of trying to get from settingInjection
  final getSettingsUseCase = PlaceholderGetSettingsUseCase();
  final updateSettingsUseCase = PlaceholderUpdateSettingsUseCase();

  return SettingsStateNotifier(
    getSettingsUseCase: getSettingsUseCase,
    updateSettingsUseCase: updateSettingsUseCase,
  );
});

/// Provider to access theme mode for simpler consumption
final themeModeProvider = Provider<settings_entity.ThemeMode>((ref) {
  final settingsThemeMode = ref.watch(settingsProvider).themeMode;
  switch(settingsThemeMode) {
    case settings_entity.ThemeMode.light: return settings_entity.ThemeMode.light;
    case settings_entity.ThemeMode.dark: return settings_entity.ThemeMode.dark;
    case settings_entity.ThemeMode.system:
    default: return settings_entity.ThemeMode.system;
  }
});

/// Provider to access locale for simpler consumption
final localeProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).locale;
});

/// Provider to access notifications enabled for simpler consumption
final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).areNotificationsEnabled;
});

/// Provider to access font scale for simpler consumption
final fontScaleProvider = Provider<double>((ref) {
  return ref.watch(settingsProvider).settings?.fontScale ?? 1.0;
});