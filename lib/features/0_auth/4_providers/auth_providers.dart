import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/injection_container.dart';
import 'auth_state_notifier.dart';

/// Provider for the AuthStateNotifier
/// 
/// Exposes the AuthStateNotifier singleton instance from GetIt
/// to be used within the Riverpod ecosystem.
final authStateNotifierProvider = 
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  // Return the singleton instance already registered in GetIt
  return sl<AuthStateNotifier>(); 
});

// You could add other auth-related providers here later, e.g.:
// final authErrorProvider = StateProvider<String?>((ref) => null); 