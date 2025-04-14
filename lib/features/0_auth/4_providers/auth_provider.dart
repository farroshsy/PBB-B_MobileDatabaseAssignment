import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../1_domain/entities/user.dart';
import '../1_domain/usecases/get_current_user_use_case.dart';
import '../1_domain/usecases/sign_in_use_case.dart';
import '../1_domain/usecases/sign_out_use_case.dart';
import '../1_domain/usecases/sign_up_use_case.dart';
import '../1_domain/usecases/send_password_reset_email_use_case.dart';
import '../3_di/auth_injection_container.dart';
import 'auth_state_notifier.dart';

/// Provider for the auth state notifier
final authNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final notifier = AuthStateNotifier(
    signInUseCase: authInjection<SignInUseCase>(),
    signUpUseCase: authInjection<SignUpUseCase>(),
    signOutUseCase: authInjection<SignOutUseCase>(),
    sendPasswordResetEmailUseCase: authInjection<SendPasswordResetEmailUseCase>(),
    getCurrentUserUseCase: authInjection<GetCurrentUserUseCase>(),
  );
  
  // Initialize the auth state (fetch current user, etc.)
  notifier.initialize();
  
  return notifier;
});

/// Provider for the current user for simpler consumption
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

/// Provider that indicates whether the user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});

/// Provider for the auth loading state for simpler consumption
final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

/// Provider for the auth error message for simpler consumption
final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).errorMessage;
});

// Keeping the old provider for backward compatibility during migration
// TODO: Remove this after migration is complete
@Deprecated('Use authNotifierProvider instead')
final authViewModelProvider = Provider((ref) {
  return ref.watch(authNotifierProvider);
});