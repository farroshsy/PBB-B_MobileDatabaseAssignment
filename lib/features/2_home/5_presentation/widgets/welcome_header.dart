import 'package:flutter/material.dart';

/// Header with welcome message for the home screen
class WelcomeHeader extends StatelessWidget {
  /// Creates a welcome header
  const WelcomeHeader({
    super.key, 
    this.greeting,
  });

  /// Personalized greeting
  final String? greeting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting ?? 'Welcome',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Explore what\'s new today',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(179),
            ),
          ),
        ],
      ),
    );
  }
}
