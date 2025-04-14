import 'connectivity_service.dart';

/// Abstract class for checking network connectivity
abstract class NetworkInfo {
  /// Returns true if the device is connected to the internet
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using ConnectivityService
class NetworkInfoImpl implements NetworkInfo {
  /// Creates a new NetworkInfoImpl instance
  NetworkInfoImpl(this.connectivityService);

  /// The connectivity service to use
  final ConnectivityService connectivityService;

  @override
  Future<bool> get isConnected => connectivityService.isConnected;
}
