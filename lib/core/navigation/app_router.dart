import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async'; // Import for StreamSubscription
import 'package:my_app/features/0_auth/4_providers/auth_state_notifier.dart'; // Import AuthStateNotifier
// Removed Riverpod and Splash imports
// import 'package:my_app/core/di/injection_container.dart'; 
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_app/features/6_splash/4_providers/splash_provider.dart'; 
// import 'package:my_app/features/6_splash/4_providers/splash_state_notifier.dart';

// Import the actual screen widgets
import 'package:my_app/features/0_auth/5_presentation/screens/login_screen.dart';
import 'package:my_app/features/2_home/5_presentation/screens/home_screen.dart';
import 'package:my_app/features/1_dashboard/5_presentation/screens/dashboard_screen.dart';
import 'package:my_app/features/3_notification/5_presentation/screens/notifications_screen.dart';
import 'package:my_app/features/4_profile/5_presentation/screens/profile_screen.dart';
import 'package:my_app/features/5_setting/5_presentation/screens/settings_screen.dart';
import 'package:my_app/features/6_splash/5_presentation/screens/splash_screen.dart';
import 'package:my_app/features/7_hive/5_presentation/screens/hive_example_screen.dart';
import 'package:my_app/features/230325_assignment/presentation/screens/assignment_screen.dart';
import 'package:my_app/core/navigation/main_shell.dart'; // Import the shell widget

/// Authentication notifier that tracks authentication state for the router
class RouterAuthNotifier extends ChangeNotifier {
  final AuthStateNotifier _authStateNotifier;
  late final StreamSubscription _authStateSubscription;
  
  bool _isAuthenticated = false;

  // Reverted constructor to only take AuthStateNotifier
  RouterAuthNotifier(this._authStateNotifier) { 
    // Initialize directly from AuthStateNotifier's current state
    _isAuthenticated = _authStateNotifier.state.isAuthenticated;

    // Listen to AuthStateNotifier for all auth changes (including splash update)
    _authStateSubscription = _authStateNotifier.stream.listen((authState) {
      final newState = authState.isAuthenticated;
      if (_isAuthenticated != newState) {
        _isAuthenticated = newState;
        notifyListeners(); 
      }
    });
    
    // Removed listener for splash provider
  }

  // Removed _updateAuthFromSplash method

  bool get isAuthenticated => _isAuthenticated;

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}

/// Application router using go_router for navigation
class AppRouter {
  /// Create app router
  AppRouter({required RouterAuthNotifier authViewModel})
      : _authViewModel = authViewModel;

  final RouterAuthNotifier _authViewModel;

  /// Get the router configuration
  GoRouter get router => GoRouter(
        routes: _routes,
        initialLocation: '/splash',
        redirect: _handleRedirect,
        refreshListenable: _authViewModel,
        debugLogDiagnostics: true,
      );

  String? _handleRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = _authViewModel.isAuthenticated;
    final location = state.uri.toString();
    final isAuthRoute = location.startsWith('/auth');
    final isSplashRoute = location == '/splash';

    print("Redirect Check: Location=$location, Auth=$isAuthenticated");

    // 1. If not authenticated and trying to access a protected route (not auth, not splash)
    if (!isAuthenticated && !isAuthRoute && !isSplashRoute) {
      print("Redirecting to /auth/login (Unauthenticated access to protected route)");
      return '/auth/login';
    }

    // 2. If authenticated and trying to access splash or auth routes
    if (isAuthenticated && (isSplashRoute || isAuthRoute)) {
      print("Redirecting to /home (Authenticated on splash/auth route)");
      return '/home';
    }

    // 3. No redirect needed
    print("No redirect needed.");
    return null;
  }

  List<RouteBase> get _routes => [
        // Splash route (outside the shell)
        GoRoute(
          path: '/splash',
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const SplashScreen(),
          ),
        ),
        // Auth routes (outside the shell)
        GoRoute(
          path: '/auth',
          redirect: (_, __) => '/auth/login',
          routes: [
            GoRoute(
              path: 'login',
              pageBuilder: (context, state) => _buildPage(
                context: context,
                state: state,
                child: const LoginScreen(),
              ),
            ),
          ],
        ),
        // ShellRoute for main app sections with persistent bottom nav
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const DashboardScreen(),
              ),
            ),
            GoRoute(
              path: '/notifications',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const NotificationsScreen(),
              ),
            ),
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const ProfileScreen(),
              ),
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const SettingsScreen(),
              ),
            ),
            GoRoute(
              path: '/hive_example',
              pageBuilder: (context, state) => _buildPage(
                context: context, state: state, child: const HiveExampleScreen(),
              ),
            ),
            GoRoute(
              path: '/assignment',
              pageBuilder: (context, state) => _buildPage(
                context: context,
                state: state,
                child: const AssignmentScreen(),
              ),
            ),
          ],
        ),
        // Redirect base path '/' to splash
        GoRoute(
          path: '/',
          redirect: (_, __) => '/splash',
        ),
      ];

  Page<dynamic> _buildPage({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
