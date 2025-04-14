import 'package:flutter/material.dart';

/// Text style variants
enum TextVariant {
  /// Display large text
  displayLarge,
  
  /// Display medium text
  displayMedium,
  
  /// Display small text
  displaySmall,
  
  /// Headline large text
  headlineLarge,
  
  /// Headline medium text
  headlineMedium,
  
  /// Headline small text
  headlineSmall,
  
  /// Title large text
  titleLarge,
  
  /// Title medium text
  titleMedium,
  
  /// Title small text
  titleSmall,
  
  /// Body large text
  bodyLarge,
  
  /// Body medium text
  bodyMedium,
  
  /// Body small text
  bodySmall,
  
  /// Label large text
  labelLarge,
  
  /// Label medium text
  labelMedium,
  
  /// Label small text
  labelSmall,
}

/// A reusable styled text widget with consistent appearance.
///
/// This component provides a standardized way to display text
/// throughout the application.
class StyledText extends StatelessWidget {
  /// Creates a styled text widget.
  ///
  /// [text] is the text to display.
  /// [variant] is the text style variant.
  /// [style] provides additional style customization.
  /// [color] overrides the default text color.
  /// [align] controls text alignment.
  /// [overflow] defines how text overflow is handled.
  /// [maxLines] limits the number of lines.
  /// [softWrap] controls whether text should wrap.
  /// [weight] overrides the font weight.
  /// [decoration] adds text decoration (underline, etc.).
  /// [fontStyle] sets the font style (italic, etc.).
  /// [letterSpacing] controls letter spacing.
  /// [wordSpacing] controls word spacing.
  /// [lineHeight] controls the line height.
  /// [isMuted] applies a muted color when true.
  const StyledText(
    this.text, {
    super.key,
    this.variant = TextVariant.bodyMedium,
    this.style,
    this.color,
    this.align,
    this.overflow,
    this.maxLines,
    this.softWrap,
    this.weight,
    this.decoration,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.lineHeight,
    this.isMuted = false,
  });

  /// The text to display
  final String text;
  
  /// Text style variant
  final TextVariant variant;
  
  /// Additional style customization
  final TextStyle? style;
  
  /// Text color
  final Color? color;
  
  /// Text alignment
  final TextAlign? align;
  
  /// Overflow behavior
  final TextOverflow? overflow;
  
  /// Maximum number of lines
  final int? maxLines;
  
  /// Whether text should wrap
  final bool? softWrap;
  
  /// Font weight
  final FontWeight? weight;
  
  /// Text decoration
  final TextDecoration? decoration;
  
  /// Font style
  final FontStyle? fontStyle;
  
  /// Letter spacing
  final double? letterSpacing;
  
  /// Word spacing
  final double? wordSpacing;
  
  /// Line height
  final double? lineHeight;
  
  /// Whether to use muted color
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Get the base style from the theme based on variant
    TextStyle? baseStyle;
    switch (variant) {
      case TextVariant.displayLarge:
        baseStyle = theme.textTheme.displayLarge;
        break;
      case TextVariant.displayMedium:
        baseStyle = theme.textTheme.displayMedium;
        break;
      case TextVariant.displaySmall:
        baseStyle = theme.textTheme.displaySmall;
        break;
      case TextVariant.headlineLarge:
        baseStyle = theme.textTheme.headlineLarge;
        break;
      case TextVariant.headlineMedium:
        baseStyle = theme.textTheme.headlineMedium;
        break;
      case TextVariant.headlineSmall:
        baseStyle = theme.textTheme.headlineSmall;
        break;
      case TextVariant.titleLarge:
        baseStyle = theme.textTheme.titleLarge;
        break;
      case TextVariant.titleMedium:
        baseStyle = theme.textTheme.titleMedium;
        break;
      case TextVariant.titleSmall:
        baseStyle = theme.textTheme.titleSmall;
        break;
      case TextVariant.bodyLarge:
        baseStyle = theme.textTheme.bodyLarge;
        break;
      case TextVariant.bodyMedium:
        baseStyle = theme.textTheme.bodyMedium;
        break;
      case TextVariant.bodySmall:
        baseStyle = theme.textTheme.bodySmall;
        break;
      case TextVariant.labelLarge:
        baseStyle = theme.textTheme.labelLarge;
        break;
      case TextVariant.labelMedium:
        baseStyle = theme.textTheme.labelMedium;
        break;
      case TextVariant.labelSmall:
        baseStyle = theme.textTheme.labelSmall;
        break;
    }
    
    // Apply customizations
    final textColor = color ?? (isMuted 
        ? theme.colorScheme.onSurface.withAlpha((255 * 0.6).round())
        : null);
    
    final customStyle = baseStyle?.copyWith(
      color: textColor,
      fontWeight: weight,
      decoration: decoration,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: lineHeight,
    );
    
    // Merge with provided style if any
    final finalStyle = customStyle != null && style != null
        ? customStyle.merge(style)
        : (customStyle ?? style);
    
    return Text(
      text,
      style: finalStyle,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
