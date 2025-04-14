import 'package:flutter/material.dart';

/// Loading indicator for the splash screen
class SplashLoadingIndicator extends StatelessWidget {
  /// Creates a splash loading indicator
  const SplashLoadingIndicator({
    super.key,
    required this.progress,
  });

  /// Progress value (0.0 to 1.0)
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
