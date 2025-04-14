import 'package:flutter/material.dart';

/// Logo widget for auth screens
class AuthLogo extends StatelessWidget {
  /// Creates an auth logo
  const AuthLogo({
    super.key,
    this.size = 120,
  });

  /// Size of the logo
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha((0.1 * 255).round()),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.lock_outline,
          size: size * 0.5,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
