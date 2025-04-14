import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/maintenance_message.dart';
import '../widgets/update_required_message.dart';
import 'package:my_app/shared/widgets/indicators/loading_indicator.dart';
import '../../4_providers/splash_provider.dart';
import '../../4_providers/splash_state_notifier.dart';
import 'package:go_router/go_router.dart';

/// Splash screen as the entry point of the application
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates a splash screen
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    
    _animationController.forward();
    
    // Start initialization
    Future.microtask(() {
      ref.read(splashNotifierProvider.notifier).initialize();
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.primary;
    
    final splashStatus = ref.watch(splashStatusProvider);
    final isLoading = ref.watch(splashLoadingProvider);
    final errorMessage = ref.watch(splashErrorProvider);
    final appConfig = ref.watch(appConfigProvider);

    // *** Add Listener for Navigation ***
    ref.listen<SplashStatus>(splashStatusProvider, (_, nextStatus) {
      if (nextStatus == SplashStatus.success) {
        final isAuthenticated = ref.read(isAuthenticatedProvider);
        print("Splash Success: Navigating based on auth ($isAuthenticated)");
        context.go(isAuthenticated ? '/home' : '/auth/login');
      }
    });
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FadeTransition(
        opacity: _fadeInAnimation, 
        child: Center(
          child: Builder(
            builder: (context) {
              // Switch on SplashStatus enum
              switch (splashStatus) {
                case SplashStatus.loading:
                case SplashStatus.initial: 
                  return _buildLoadingContent(); // Simplified loading view
                  
                case SplashStatus.error:
                  return _buildErrorContent(errorMessage ?? 'Unknown error');
                  
                case SplashStatus.maintenance:
                  // Fetch appConfig to potentially display message details if needed
                  final appConfig = ref.watch(appConfigProvider);
                  return MaintenanceMessage(message: appConfig.maintenanceMessage);
                  
                case SplashStatus.updateRequired:
                  // Fetch appConfig to potentially display update URL and versions
                  final appConfig = ref.watch(appConfigProvider);
                  return UpdateRequiredMessage(
                    updateUrl: appConfig.updateUrl, 
                    currentVersion: appConfig.appVersion, // Pass current version
                    requiredVersion: appConfig.minimumRequiredVersion, // Pass required version
                  );
                  
                case SplashStatus.success:
                  // Show loading briefly; GoRouter handles navigation.
                  return _buildLoadingContent(); 
              }
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildLoadingContent() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingIndicator(size: LoadingSize.large, color: Colors.white),
        SizedBox(height: 16),
        Text('Loading...', style: TextStyle(color: Colors.white70)),
      ],
    );
  }
  
  Widget _buildErrorContent(String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.white, 
        ),
        const SizedBox(height: 24),
        Text(
          'Something went wrong',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            ref.read(splashNotifierProvider.notifier).initialize();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
          ),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
