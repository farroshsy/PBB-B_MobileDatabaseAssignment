import 'package:flutter/material.dart';

/// Text style definitions for the application
///
/// This class holds raw TextStyle definitions that can be used to build
/// a consistent typography system. These styles are used by AppTypography
/// to create complete TextTheme objects.
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  /// The default font family for the application
  static const String fontFamily = 'Roboto';

  /// Font weights used throughout the app
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemiBold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;

  /// Base text style that all other styles extend
  static const TextStyle _baseTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: weightRegular,
    height: 1.5,
    letterSpacing: 0.15,
  );

  /// Display styles (largest text)
  static final TextStyle displayLarge = _baseTextStyle.copyWith(
    fontSize: 57,
    fontWeight: weightLight,
    height: 1.12,
    letterSpacing: -0.25,
  );

  static final TextStyle displayMedium = _baseTextStyle.copyWith(
    fontSize: 45,
    fontWeight: weightLight,
    height: 1.16,
  );

  static final TextStyle displaySmall = _baseTextStyle.copyWith(
    fontSize: 36,
    fontWeight: weightRegular,
    height: 1.22,
  );

  /// Headline styles
  static final TextStyle headlineLarge = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: weightRegular,
    height: 1.25,
  );

  static final TextStyle headlineMedium = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: weightRegular,
    height: 1.29,
  );

  static final TextStyle headlineSmall = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: weightRegular,
    height: 1.33,
  );

  /// Title styles
  static final TextStyle titleLarge = _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: weightMedium,
    height: 1.27,
  );

  static final TextStyle titleMedium = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: weightMedium,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static final TextStyle titleSmall = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: weightMedium,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Body styles
  static final TextStyle bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: weightRegular,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static final TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: weightRegular,
    height: 1.43,
    letterSpacing: 0.25,
  );

  static final TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: weightRegular,
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Label styles
  static final TextStyle labelLarge = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: weightMedium,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static final TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: weightMedium,
    height: 1.33,
    letterSpacing: 0.5,
  );

  static final TextStyle labelSmall = _baseTextStyle.copyWith(
    fontSize: 11,
    fontWeight: weightMedium,
    height: 1.45,
    letterSpacing: 0.5,
  );

  /// Light theme specific styles
  static final TextStyle lightDisplayLarge = displayLarge.copyWith(
    color: Colors.black87,
  );

  static final TextStyle lightBodyMedium = bodyMedium.copyWith(
    color: Colors.black87,
  );

  /// Dark theme specific styles
  static final TextStyle darkDisplayLarge = displayLarge.copyWith(
    color: Colors.white,
  );

  static final TextStyle darkBodyMedium = bodyMedium.copyWith(
    color: Colors.white,
  );
}
