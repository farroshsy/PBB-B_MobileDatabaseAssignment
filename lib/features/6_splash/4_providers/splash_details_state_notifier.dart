import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/usecase/usecase.dart';
import '../1_domain/entities/splash_details_data.dart';
import '../1_domain/usecases/get_splash_details_usecase.dart';
import '../1_domain/usecases/load_splash_details_use_case.dart';

/// Splash details state class containing all the splash details state
class SplashDetailsState {
  /// Creates a splash details state
  const SplashDetailsState({
    this.isLoading = false,
    this.errorMessage,
    this.details,
  });

  /// Whether details are loading
  final bool isLoading;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Splash details data
  final SplashDetailsData? details;

  /// Creates a copy of the state with specified fields updated
  SplashDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    SplashDetailsData? details,
    bool clearError = false,
    bool clearDetails = false,
  }) {
    return SplashDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      details: clearDetails ? null : (details ?? this.details),
    );
  }
}

/// Splash details state notifier that manages the splash details state
class SplashDetailsStateNotifier extends StateNotifier<SplashDetailsState> {
  /// Creates a splash details state notifier
  SplashDetailsStateNotifier({
    required GetSplashDetailsUseCase getSplashDetailsUseCase,
    required LoadSplashDetailsUseCase loadSplashDetailsUseCase,
  }) : _getSplashDetailsUseCase = getSplashDetailsUseCase,
       _loadSplashDetailsUseCase = loadSplashDetailsUseCase,
       super(const SplashDetailsState());

  final GetSplashDetailsUseCase _getSplashDetailsUseCase;
  final LoadSplashDetailsUseCase _loadSplashDetailsUseCase;

  /// Load splash details
  Future<void> loadSplashDetails() async {
    state = state.copyWith(isLoading: true, clearError: true, clearDetails: true);

    try {
      // First, load details from the backend
      await _loadSplashDetailsUseCase(const NoParams());
      
      // Then, get the loaded details
      final detailsResult = await _getSplashDetailsUseCase(const NoParams());
      
      // Process the result of getSplashDetailsUseCase
      detailsResult.fold(
        (failure) {
          // Handle failure case if needed
          state = state.copyWith(
            errorMessage: failure.message,
            isLoading: false,
          );
        },
        (splashData) {
          // Now directly assign the SplashDetailsData object
          state = state.copyWith(
            details: splashData, 
            isLoading: false,
          );
        },
      );

    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }
  }
}