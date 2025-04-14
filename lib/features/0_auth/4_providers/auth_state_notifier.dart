import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../1_domain/entities/auth_credentials.dart';
import '../1_domain/entities/user.dart';
import '../1_domain/usecases/get_current_user_use_case.dart';
import '../1_domain/usecases/sign_in_use_case.dart';
import '../1_domain/usecases/sign_out_use_case.dart';
import '../1_domain/usecases/sign_up_use_case.dart';
import '../1_domain/usecases/send_password_reset_email_use_case.dart';

/// Enumeration of auth states
enum AuthStatus {
  /// Initial state
  initial,

  /// Authenticating state
  authenticating,

  /// Authenticated state
  authenticated,

  /// Unauthenticated state
  unauthenticated,

  /// Error state
  error,
}

/// Auth state class containing all the auth state
class AuthState {
  /// Creates an auth state
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.isLoading = false,
  });

  /// Current status of the auth flow
  final AuthStatus status;

  /// Current user
  final User? user;

  /// Error message if any
  final String? errorMessage;

  /// Whether auth is loading
  final bool isLoading;

  /// Whether user is authenticated
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// Creates a copy of the state with specified fields updated
  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Auth state notifier that manages the auth state
class AuthStateNotifier extends StateNotifier<AuthState> {
  /// Creates an auth state notifier
  AuthStateNotifier({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _sendPasswordResetEmailUseCase = sendPasswordResetEmailUseCase,
        super(const AuthState());

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;

  /// Initialize auth state by checking current user
  Future<void> initialize() async {
    await getCurrentUser();
  }

  /// Sign in with email and password
  /// Returns true if sign in was successful
  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.authenticating,
      clearError: true,
    );

    final credentials = AuthCredentials(email: email, password: password);
    final result = await _signInUseCase(credentials);

    return result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (user) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
        return true;
      },
    );
  }

  /// Sign up with email and password
  /// Returns true if sign up was successful
  Future<bool> signUp(
      String email, String password, String? displayName) async {
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.authenticating,
      clearError: true,
    );

    final credentials = AuthCredentials(
      email: email,
      password: password,
      displayName: displayName,
    );

    final result = await _signUpUseCase(credentials);

    return result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (user) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
        return true;
      },
    );
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _signOutUseCase(const NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
        isLoading: false,
      ),
      (_) => state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        clearUser: true,
      ),
    );
  }

  /// Get current user
  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getCurrentUserUseCase(const NoParams());

    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          // If network failure, don't show error, just set unauthenticated
          state = state.copyWith(
            status: AuthStatus.unauthenticated,
            isLoading: false,
            clearUser: true,
          );
          return;
        }

        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
          isLoading: false,
        );
      },
      (user) => state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
      ),
    );
  }

  /// Send password reset email
  /// Returns true if password reset email was sent successfully
  Future<bool> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _sendPasswordResetEmailUseCase(email);

    return result.fold(
      (failure) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (_) {
        state = state.copyWith(
          isLoading: false,
        );
        return true;
      },
    );
  }

  /// Allows forcibly updating the auth state, e.g., after splash screen check
  void updateAuthFromSplash(bool isAuthenticated, {User? user}) {
    print("AuthStateNotifier: Updating auth state from splash: $isAuthenticated");
    if (isAuthenticated) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user ?? state.user, // Keep existing user if not provided
        isLoading: false,
        clearError: true,
      );
    } else {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        isLoading: false,
        clearUser: true,
        clearError: true,
      );
    }
  }
}
