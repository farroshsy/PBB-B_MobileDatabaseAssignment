import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../4_providers/splash_details_provider.dart';

/// Detailed view screen for splash feature
class SplashDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a splash details screen
  const SplashDetailsScreen({super.key});

  @override
  ConsumerState<SplashDetailsScreen> createState() => _SplashDetailsScreenState();
}

class _SplashDetailsScreenState extends ConsumerState<SplashDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Load data on screen initialization using the state notifier
    Future.microtask(() {
      ref.read(splashDetailsNotifierProvider.notifier).loadSplashDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state through the providers
    final isLoading = ref.watch(splashDetailsLoadingProvider);
    final errorMessage = ref.watch(splashDetailsErrorProvider);
    final details = ref.watch(splashDetailsDataProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash Details'),
      ),
      body: PageContainer(
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error occurred',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(splashDetailsNotifierProvider.notifier).loadSplashDetails();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            
            // Display the details if available
            if (details != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Splash Details Loaded',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    // Display some example data if available
                    Text(
                      details.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }
            
            // Fallback when no details are available
            return const Center(
              child: Text('No details available'),
            );
          },
        ),
      ),
    );
  }
}
