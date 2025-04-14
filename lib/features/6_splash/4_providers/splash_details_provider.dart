import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../1_domain/usecases/get_splash_details_usecase.dart';
import '../1_domain/usecases/load_splash_details_use_case.dart';
import '../1_domain/usecases/get_splash_details_usecase_impl.dart';
import '../1_domain/usecases/load_splash_details_use_case_impl.dart';
import '../1_domain/entities/splash_details_data.dart';
import 'splash_details_state_notifier.dart';

/// Provider for GetSplashDetailsUseCase (using the implementation)
final getSplashDetailsUseCaseProvider = Provider<GetSplashDetailsUseCase>((ref) {
  // Return the implementation instance - assumes it might be registered in sl or created directly
  // If not registered in sl, create it directly:
  return GetSplashDetailsUseCaseImpl();
});

/// Provider for LoadSplashDetailsUseCase (using the implementation)
final loadSplashDetailsUseCaseProvider = Provider<LoadSplashDetailsUseCase>((ref) {
  // Return the implementation instance - assumes it might be registered in sl or created directly
  // If not registered in sl, create it directly:
  return LoadSplashDetailsUseCaseImpl();
});

/// Provider for the splash details state notifier
final splashDetailsStateNotifierProvider = StateNotifierProvider<SplashDetailsStateNotifier, SplashDetailsState>((ref) {
  // Inject the use cases using their providers
  final getSplashDetailsUseCase = ref.watch(getSplashDetailsUseCaseProvider);
  final loadSplashDetailsUseCase = ref.watch(loadSplashDetailsUseCaseProvider);
  
  return SplashDetailsStateNotifier(
    getSplashDetailsUseCase: getSplashDetailsUseCase,
    loadSplashDetailsUseCase: loadSplashDetailsUseCase,
  );
});

/// Provider for whether splash details are loading
final splashDetailsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(splashDetailsStateNotifierProvider).isLoading;
});

/// Provider for the splash details error message
final splashDetailsErrorProvider = Provider<String?>((ref) {
  return ref.watch(splashDetailsStateNotifierProvider).errorMessage;
});

/// Provider for the splash details data
final splashDetailsDataProvider = Provider<SplashDetailsData?>((ref) {
  return ref.watch(splashDetailsStateNotifierProvider).details;
});