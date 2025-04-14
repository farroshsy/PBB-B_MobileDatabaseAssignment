import 'package:equatable/equatable.dart';

/// Data model representing details loaded during the splash phase.
/// NOTE: This is an example structure. Adapt to your actual data needs.
class SplashDetailsData extends Equatable {
  final String welcomeMessage;
  // Add other fields as needed, e.g., user session info, specific config values

  const SplashDetailsData({required this.welcomeMessage});

  // Factory constructor for creating an empty/default instance if needed
  // factory SplashDetailsData.empty() => const SplashDetailsData(welcomeMessage: '');

  @override
  List<Object?> get props => [welcomeMessage];
} 