import 'package:flutter/material.dart';

/// Message to display when app is in maintenance mode
class MaintenanceMessage extends StatelessWidget {
  /// Creates a maintenance message
  const MaintenanceMessage({
    super.key,
    this.message,
  });

  /// Optional maintenance message
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.build_circle,
          size: 64,
          color: Colors.white,
        ),
        const SizedBox(height: 24),
        Text(
          'Under Maintenance',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            message ?? 'We are currently updating our servers. Please check back soon.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
