import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../1_domain/entities/hive.dart';
import '../1_domain/usecases/get_hive_use_case.dart';
import '../1_domain/usecases/update_hive_use_case.dart';
import '../3_di/hive_injection_container.dart';

/// Profile state class containing all state information
class ProfileState {
  /// Creates a profile state
  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
    this.isUpdating = false,
  });

  /// User profile data
  final Profile? profile;
  
  /// Whether profile is loading
  final bool isLoading;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Whether profile is being updated
  final bool isUpdating;

  /// Creates a copy of the state with specified fields updated
  ProfileState copyWith({
    Profile? profile,
    bool? isLoading,
    String? errorMessage,
    bool? isUpdating,
    bool clearError = false,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
  
  /// Check if profile is loaded
  bool get isProfileLoaded => profile != null;
  
  /// Get user name or empty string
  String get userName => profile?.name ?? '';
  
  /// Get user email or empty string
  String get userEmail => profile?.email ?? '';
  
  /// Get user photo URL or null
  String? get userPhotoUrl => profile?.photoUrl;
}

/// Profile State Notifier that manages the profile state
class ProfileStateNotifier extends StateNotifier<ProfileState> {
  /// Creates a profile state notifier
  ProfileStateNotifier({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  }) : _getProfileUseCase = getProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       super(const ProfileState());

  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  /// Load user profile
  Future<bool> loadProfile() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getProfileUseCase(NoParams());

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (profile) {
        state = state.copyWith(
          profile: profile,
          isLoading: false,
        );
        return true;
      },
    );
  }
  
  /// Update user profile
  Future<bool> updateProfile(Profile updatedProfile) async {
    state = state.copyWith(isUpdating: true, clearError: true);

    final result = await _updateProfileUseCase(
      UpdateProfileParams(profile: updatedProfile),
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isUpdating: false,
        );
        return false;
      },
      (updatedProfile) {
        state = state.copyWith(
          profile: updatedProfile,
          isUpdating: false,
        );
        return true;
      },
    );
  }
}

/// Provider for the profile state notifier
final profileProvider = StateNotifierProvider<ProfileStateNotifier, ProfileState>((ref) {
  return ProfileStateNotifier(
    getProfileUseCase: profileInjection<GetProfileUseCase>(),
    updateProfileUseCase: profileInjection<UpdateProfileUseCase>(),
  );
});

/// Provider to access profile for simpler consumption
final userProfileProvider = Provider<Profile?>((ref) {
  return ref.watch(profileProvider).profile;
});

/// Provider to access user name for simpler consumption
final userNameProvider = Provider<String>((ref) {
  return ref.watch(profileProvider).userName;
});

/// Provider to access user email for simpler consumption
final userEmailProvider = Provider<String>((ref) {
  return ref.watch(profileProvider).userEmail;
});

/// Provider to access user photo URL for simpler consumption
final userPhotoUrlProvider = Provider<String?>((ref) {
  return ref.watch(profileProvider).userPhotoUrl;
});