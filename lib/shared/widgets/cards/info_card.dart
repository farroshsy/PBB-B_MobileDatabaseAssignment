import 'package:flutter/material.dart';
import 'app_card.dart';

/// Information card types that determine appearance
enum InfoCardType {
  /// Standard information
  info,
  
  /// Success notification
  success,
  
  /// Warning notification
  warning,
  
  /// Error notification
  error,
}

/// A card for displaying information, warnings, or errors.
///
/// Use this to highlight information to the user.
class InfoCard extends StatelessWidget {
  /// Creates an information card.
  ///
  /// [title] is the optional card title.
  /// [message] is the main message text.
  /// [type] defines the card's appearance.
  /// [icon] is an optional icon to display.
  /// [action] is an optional action button.
  /// [padding] defines the internal padding.
  /// [margin] defines the external spacing.
  /// [onDismiss] enables dismissal and provides a callback.
  const InfoCard({
    required this.message,
    super.key,
    this.title,
    this.type = InfoCardType.info,
    this.icon,
    this.action,
    this.padding,
    this.margin,
    this.onDismiss,
  });

  /// Card title
  final String? title;
  
  /// Card message
  final String message;
  
  /// Card type
  final InfoCardType type;
  
  /// Optional icon
  final IconData? icon;
  
  /// Optional action button
  final Widget? action;
  
  /// Card padding
  final EdgeInsetsGeometry? padding;
  
  /// Card margin
  final EdgeInsetsGeometry? margin;
  
  /// Dismiss callback
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Determine colors and icon based on type
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    IconData typeIcon;
    
    switch (type) {
      case InfoCardType.info:
        backgroundColor = Colors.blue.withAlpha((255 * 0.1).round());
        textColor = Colors.blue.shade800;
        borderColor = Colors.blue.shade300;
        typeIcon = Icons.info_outline;
        break;
      case InfoCardType.success:
        backgroundColor = Colors.green.withAlpha((255 * 0.1).round());
        textColor = Colors.green.shade800;
        borderColor = Colors.green.shade300;
        typeIcon = Icons.check_circle_outline;
        break;
      case InfoCardType.warning:
        backgroundColor = Colors.orange.withAlpha((255 * 0.1).round());
        textColor = Colors.orange.shade800;
        borderColor = Colors.orange.shade300;
        typeIcon = Icons.warning_amber_outlined;
        break;
      case InfoCardType.error:
        backgroundColor = Colors.red.withAlpha((255 * 0.1).round());
        textColor = Colors.red.shade800;
        borderColor = Colors.red.shade300;
        typeIcon = Icons.error_outline;
        break;
    }
    
    // Use provided icon or default for the type
    final cardIcon = icon ?? typeIcon;
    
    Widget card = AppCard(
      padding: padding ?? const EdgeInsets.all(12.0),
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0.0,
      color: backgroundColor,
      border: BorderSide(color: borderColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(cardIcon, color: textColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(height: 8),
                  action!,
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: textColor.withAlpha((255 * 0.7).round()),
              onPressed: onDismiss,
            ),
        ],
      ),
    );
    
    // Make the card dismissible if a callback is provided
    if (onDismiss != null) {
      return Dismissible(
        key: ValueKey('info-card-${title ?? ''}-$message'),
        direction: DismissDirection.horizontal,
        onDismissed: (_) => onDismiss!(),
        child: card,
      );
    }
    
    return card;
  }
}
