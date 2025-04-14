import 'package:flutter/material.dart';

/// Page title with optional subtitle
class PageTitle extends StatelessWidget {
  /// Creates a page title
  const PageTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    this.bottomSpacing = 0,
  });

  /// Main title text
  final String title;
  
  /// Optional subtitle text
  final String? subtitle;
  
  /// Horizontal alignment
  final CrossAxisAlignment alignment;
  
  /// Space to add below the title
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha((255 * 0.7).round()),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
