import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the auth provider
import 'package:my_app/features/0_auth/4_providers/auth_providers.dart';
// TODO: Import AuthStateNotifier provider later
// import 'package:my_app/features/0_auth/4_providers/auth_state_notifier.dart';
// import 'package:my_app/core/di/injection_container.dart'; // To access sl

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _logout(WidgetRef ref) {
    // Call signOut using the Riverpod provider
    ref.read(authStateNotifierProvider.notifier).signOut();
    print('Logout action dispatched via provider.');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Watch auth state to potentially display user info
    // final authState = ref.watch(authStateNotifierProvider);
    // final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(ref),
          ),
        ],
      ),
      body: const Center(
        // TODO: Replace with actual home screen content
        child: Text(
          'Welcome Home!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 