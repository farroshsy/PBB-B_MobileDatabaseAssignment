import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/0_auth/4_providers/auth_providers.dart';

// Define paths for navigation (can be shared or redefined here)
const String homePath = '/home';
const String dashboardPath = '/dashboard';
const String notificationsPath = '/notifications';
const String profilePath = '/profile';
const String settingsPath = '/settings';

class MainShell extends ConsumerStatefulWidget {
  final Widget child; // The screen content provided by GoRouter

  const MainShell({required this.child, super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == homePath) return 0;
    if (location == dashboardPath) return 1;
    if (location == notificationsPath) return 2;
    if (location == profilePath) return 3;
    if (location == settingsPath) return 4;
    return 0; // Default to home
  }

  void _onItemTapped(int index, BuildContext context) {
    String destinationPath;
    switch (index) {
      case 0: destinationPath = homePath; break;
      case 1: destinationPath = dashboardPath; break;
      case 2: destinationPath = notificationsPath; break;
      case 3: destinationPath = profilePath; break;
      case 4: destinationPath = settingsPath; break;
      default: destinationPath = homePath;
    }
    context.go(destinationPath);
  }

  void _logout(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).signOut();
    print('Logout action dispatched via provider.');
    // GoRouter redirect logic will handle navigation to login
  }

  String _getAppBarTitle(int index) {
     switch (index) {
      case 0: return 'Home';
      case 1: return 'Dashboard';
      case 2: return 'Notifications';
      case 3: return 'Profile';
      case 4: return 'Settings';
      default: return 'App';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(currentIndex)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(ref),
          ),
        ],
      ),
      body: widget.child, // Display the active screen content here
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
} 