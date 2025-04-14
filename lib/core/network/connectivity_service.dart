import 'package:connectivity_plus/connectivity_plus.dart';

/// Service for checking network connectivity
class ConnectivityService {
  /// Default constructor
  ConnectivityService() : _connectivity = Connectivity();

  final Connectivity _connectivity;

  /// Checks if the device has an active network connection
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    // Check if any result is not 'none' (which means disconnected)
    return results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
  }

  /// Stream of connectivity changes
  Stream<ConnectivityResult> get onConnectivityChanged {
    // The connectivity_plus package returns Stream<List<ConnectivityResult>>
    // We map it to return the first result in the list to match our API
    return _connectivity.onConnectivityChanged.map((results) {
      // If the list is empty, return none, otherwise return the first result
      return results.isNotEmpty ? results.first : ConnectivityResult.none;
    });
  }
}
