import 'package:flutter/material.dart';

/// A reusable dialog with consistent styling.
///
/// This component provides a standardized way to show dialogs
/// throughout the application.
class AppDialog extends StatelessWidget {
  /// Creates a standard app dialog.
  ///
  /// [title] is the dialog title.
  /// [content] is the dialog content.
  /// [actions] are the dialog actions, typically buttons.
  /// [maxWidth] constrains the maximum width of the dialog.
  /// [padding] customizes the internal padding.
  /// [contentPadding] customizes the padding around the content.
  /// [barrierDismissible] controls whether tapping outside dismisses the dialog.
  /// [titleBuilder] provides custom title widget builder.
  /// [scrollable] makes the content scrollable when true.
  const AppDialog({
    required this.title,
    required this.content,
    this.actions = const [],
    super.key,
    this.maxWidth = 400.0,
    this.padding,
    this.contentPadding,
    this.barrierDismissible = true,
    this.titleBuilder,
    this.scrollable = false,
  });

  /// The dialog title
  final String title;
  
  /// The dialog content
  final Widget content;
  
  /// The dialog actions (buttons)
  final List<Widget> actions;
  
  /// The maximum width of the dialog
  final double maxWidth;
  
  /// Overall padding for the dialog
  final EdgeInsetsGeometry? padding;
  
  /// Padding around the content
  final EdgeInsetsGeometry? contentPadding;
  
  /// Whether tapping outside dismisses the dialog
  final bool barrierDismissible;
  
  /// Custom title widget builder
  final Widget Function(BuildContext, String)? titleBuilder;
  
  /// Whether the content is scrollable
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              if (titleBuilder != null)
                titleBuilder!(context, title)
              else
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              const SizedBox(height: 16.0),
              
              // Content with optional scrolling
              scrollable
                  ? Flexible(
                      child: SingleChildScrollView(
                        padding: contentPadding,
                        child: content,
                      ),
                    )
                  : Padding(
                      padding: contentPadding ?? EdgeInsets.zero,
                      child: content,
                    ),
              const SizedBox(height: 16.0),
              
              // Actions
              if (actions.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions.map((action) {
                    final index = actions.indexOf(action);
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index > 0 ? 8.0 : 0.0,
                      ),
                      child: action,
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Shows the dialog.
  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => this,
    );
  }
  
  /// Creates and shows a confirmation dialog.
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(context);
    
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelLabel),
          ),
          ElevatedButton(
            style: destructive
                ? ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  )
                : null,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }
}
