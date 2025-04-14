import 'package:flutter/foundation.dart';
// Needed for Either
// Needed for SplashDetailsData

// Needed for Failure
import 'package:my_app/core/usecase/usecase.dart'; // Needed for UseCase/NoParams
// Domain layer imports
import '../../1_domain/entities/splash_details_data.dart';
import '../../1_domain/usecases/get_splash_details_usecase.dart';
// Import the specific use cases needed for details, if any.
// If details screen just shows data loaded by the main splash screen,
// this ViewModel might not need its own use cases.
// import '../../1_domain/usecases/...';
// import '../../1_domain/usecases/get_specific_config_usecase.dart'; // EXAMPLE: Replace with actual use case
// import '../../3_di/splash_injection_container.dart'; // Not used directly if passing use cases

/// View model for the Splash Details Screen (if one is needed)
/// Often, the main SplashViewModel handles all necessary loading.
class SplashDetailsViewModel extends ChangeNotifier {
  // Inject the actual use case
  final GetSplashDetailsUseCase _getSplashDetailsUseCase;

  /// Creates a splash details view model
  // Note: This use case needs to be provided via Dependency Injection (e.g., get_it)
  SplashDetailsViewModel(
    {required GetSplashDetailsUseCase getSplashDetailsUseCase,}
  ) : _getSplashDetailsUseCase = getSplashDetailsUseCase 
  {
     // Initialize fields if needed
  }

  // Add fields for any specific data this screen needs
  // Holds the data loaded by the use case
  SplashDetailsData? _detailsData;
  bool _isLoading = false;
  String? _errorMessage;

  // Add getters for state
  // Getter for the loaded data
  SplashDetailsData? get detailsData => _detailsData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load specific details for the splash screen (if applicable)
  Future<bool> loadSplashDetails(/* Parameters if needed */) async {
    _setLoading(true);
    _clearError();

    // TODO: Implement loading logic using injected use cases
    // Example: final result = await _getSpecificConfigUseCase(NoParams());

    // Call the injected use case
    final result = await _getSplashDetailsUseCase(NoParams());

    // Handle the result (Either Failure or Success)
    return result.fold(
      (failure) {
        _setError(failure.message); // Use the actual failure message
        _setLoading(false);
        return false; // Indicate failure
      },
      (data) {
        _detailsData = data; // Store the loaded data
        _setLoading(false);
        notifyListeners(); // Notify listeners about the new data
        return true; // Indicate success
      },
    );
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setError(String message) {
    _errorMessage = message;
    // No need to notifyListeners here as it's usually called with setLoading(false)
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      // Potentially notifyListeners if clearing error should update UI immediately
    }
  }
}

// Define Params class if needed by a specific details use case