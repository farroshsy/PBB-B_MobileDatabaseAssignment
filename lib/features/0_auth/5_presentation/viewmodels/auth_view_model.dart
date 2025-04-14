import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/core/di/injection_container.dart';
import '../../1_domain/entities/auth_credentials.dart';
import '../../1_domain/entities/user.dart';
import '../../1_domain/usecases/get_current_user_use_case.dart';
import '../../1_domain/usecases/sign_in_use_case.dart';
import '../../1_domain/usecases/sign_out_use_case.dart';
import '../../1_domain/usecases/sign_up_use_case.dart';
import '../../1_domain/usecases/send_password_reset_email_use_case.dart'; // Import the use case

/// Authentication view model for managing auth state and operations
class AuthViewModel extends ChangeNotifier {
  /// Creates an auth view model with the required use cases
  AuthViewModel({
    SignInUseCase? signInUseCase,
    SignUpUseCase? signUpUseCase,
    SignOutUseCase? signOutUseCase,
    SendPasswordResetEmailUseCase?
        sendPasswordResetEmailUseCase, // Added parameter
    GetCurrentUserUseCase? getCurrentUserUseCase,
  })  : _signInUseCase = signInUseCase ?? sl<SignInUseCase>(),
        _signUpUseCase = signUpUseCase ?? sl<SignUpUseCase>(),
        _signOutUseCase = signOutUseCase ?? sl<SignOutUseCase>(),
        _sendPasswordResetEmailUseCase = sendPasswordResetEmailUseCase ??
            sl<SendPasswordResetEmailUseCase>(), // Initialize the use case
        _getCurrentUserUseCase =
            getCurrentUserUseCase ?? sl<GetCurrentUserUseCase>();

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final SendPasswordResetEmailUseCase
      _sendPasswordResetEmailUseCase; // Added field
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  /// The current authenticated user
  User? get user => _user;

  /// Whether authentication operations are in progress
  bool get isLoading => _isLoading;

  /// The current error message, if any
  String? get errorMessage => _errorMessage;

  /// Whether the user is authenticated
  bool get isAuthenticated => _user != null;

  /// Initialize the view model by loading the current user
  Future<void> initialize() async {
    await getCurrentUser();
  }

  /// Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    final credentials = AuthCredentials(email: email, password: password);
    final result = await _signInUseCase(credentials);

    return _handleAuthResult(result);
  }

  /// Sign up with email and password
  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    _clearError();

    final credentials = AuthCredentials(email: email, password: password);
    final result = await _signUpUseCase(credentials);

    return _handleAuthResult(result);
  }

  /// Sign out the current user
  Future<bool> signOut() async {
    _setLoading(true);
    _clearError();

    final result = await _signOutUseCase(NoParams());

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (_) {
        _user = null;
        _setLoading(false);
        notifyListeners();
        return true;
      },
    );
  }

  /// Get the current authenticated user
  Future<bool> getCurrentUser() async {
    _setLoading(true);
    _clearError();

    final result = await _getCurrentUserUseCase(NoParams());

    return _handleAuthResult(result);
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _clearError();

    final result = await _sendPasswordResetEmailUseCase(email);

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (_) {
        _setLoading(false);
        notifyListeners();
        return true;
      },
    );
  }

  // Helper method to handle authentication results
  bool _handleAuthResult(Either<Failure, User> result) {
    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (user) {
        _user = user;
        _setLoading(false);
        notifyListeners();
        return true;
      },
    );
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
