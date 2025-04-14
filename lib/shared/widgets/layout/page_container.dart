import 'package:flutter/material.dart';

/// Standard page container with consistent padding
class PageContainer extends StatelessWidget {
  /// Creates a page container
  const PageContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.safeArea = true,
    this.scrollable = true,
  });

  /// Child widget
  final Widget child;
  
  /// Container padding
  final EdgeInsetsGeometry padding;
  
  /// Whether to use safe area
  final bool safeArea;
  
  /// Whether content is scrollable
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: child,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: content,
      );
    }

    if (safeArea) {
      content = SafeArea(child: content);
    }

    return content;
  }
}
